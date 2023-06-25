import Foundation
import UIKit

protocol IMenuPresenter: AnyObject {
    var numberOfRowsInSection: Int { get }
    var sections: [ListSections] { get set }
    func didScroll(_ y: CGFloat)
    func getFoodByIndex(_ index: Int) -> FoodViewModel
    func didSelectCategory(_ string: String)
    func loadImageData(_ string: String, completion: @escaping (Data) -> ())
    func onViewAttached(controller: ItemViewController)
}

final class MenuPresenter {
    
    private weak var controller: ItemViewController?
    private let interactor: IMenuInteractor
    
    private var scrollFlag = false
    
    var sections: [ListSections] = [.ads,
                                    .category(Category.allCases)]
    
    private var foodArray: [FoodViewModel] = []
    
    init(interactor: IMenuInteractor) {
        self.interactor = interactor
    }
}

extension MenuPresenter: IMenuPresenter {
    
    var numberOfRowsInSection: Int {
        get {
            foodArray.count
        }
    }
    
    func didScroll(_ y: CGFloat) {
        if y > 0 && scrollFlag == false {
            scrollFlag = true
            controller?.didScroll(state: .up)
        }
        
        if y < 0 && scrollFlag == true {
            scrollFlag = false
            controller?.didScroll(state: .down)
        }
    }
    
    func getFoodByIndex(_ index: Int) -> FoodViewModel {
        foodArray[index]
    }
    
    func didSelectCategory(_ string: String) {
        guard let row = foodArray.firstIndex(where: { $0.category == string }) else { return }
        
        controller?.scrollTo(row: row, section: 0)
    }
    
    func loadImageData(_ string: String, completion: @escaping (Data) -> ()) {
        interactor.loadImageData(string) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure(let error):
                print("ERROR --> \(error)")
            }
        }
    }
    
    func onViewAttached(controller: ItemViewController) {
        self.controller = controller
        loadData()
    }
}

private extension MenuPresenter {
    
    func loadData() {
        interactor.loadData { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let array):
                self.foodArray.append(contentsOf: array)
                
                DispatchQueue.main.async {
                    self.controller?.reloadData()
                }
            case .failure(let error):
                print("ERROR --> \(error)")
            }
        }
    }
}
