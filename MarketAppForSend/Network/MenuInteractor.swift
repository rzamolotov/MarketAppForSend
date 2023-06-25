import UIKit

protocol IMenuInteractor: AnyObject {
    func loadImageData(_ string: String, completion: @escaping(Result<Data, Error>) -> ())
    func loadData(completion: @escaping (Result<[FoodViewModel], Error>) -> ())
}

final class MenuInteractor {
    
    private let network: INetworkService
    
    private let group = DispatchGroup()
    
    init(network: INetworkService) {
        self.network = network
    }
}

extension MenuInteractor: IMenuInteractor {
    
    func loadImageData(_ string: String, completion: @escaping(Result<Data, Error>) -> ()) {
        network.loadImageFrom(url: string, completion: completion)
    }
    
    func loadData(completion: @escaping (Result<[FoodViewModel], Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            for category in Category.allCases {
                
                let category = category.rawValue
                
                self.group.enter()
                
                self.network.loadFood(category: category) { result in
                    switch result {
                        
                    case .success(let arr):
                        guard let arr = arr.menuItems else { return }
                        
                        let res = arr.compactMap { FoodViewModel(model: $0, category: category) }
                        
                        completion(.success(res))
                        self.group.leave()
                    case .failure(let err):
                        completion(.failure(err))
                    }
                    self.group.wait()
                }
                self.group.wait()
            }
        }
    }
}
