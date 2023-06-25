//
//  NetworkServices.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 25.06.2023.
//

import UIKit

protocol INetworkService: AnyObject {
    func loadFood(category: String,
                  completion: @escaping (Result<FoodMenuSettings, Error>) -> ())
    func loadImageFrom(url: String,
                       completion: @escaping(Result<Data, Error>) -> ())
}

final class NetworkService {
    
    private enum Api {
        static let key = "5abbbc3716094d93b1ca6e7cbff63ea1"
    }
    
    private let baseUrl = "https://api.spoonacular.com/"
    
    private let session = URLSession.shared
}

extension NetworkService: INetworkService {
    
    func loadFood(category: String,
                  completion: @escaping (Result<FoodMenuSettings, Error>) -> ()) {
        let api = baseUrl + "food/menuItems/search?query=" + "\(category)" + "&number=10&apiKey=" + Api.key
        
        loadData(api: api, completion: completion)
    }
    
    func loadImageFrom(url: String,
                       completion: @escaping(Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
        }.resume()
    }
}

private extension NetworkService {
    
    func loadData<T: Decodable>(api: String,
                                completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: api) else { return }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
