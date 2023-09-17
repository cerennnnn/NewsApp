//
//  NetworkManager.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchNews(url: URL, completion: @escaping (Result<NewsModel, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
                if let error {
                    completion(.failure(error))
                }
                
                guard let data else {
                    completion(.failure(NSError(domain: "Data Error", code: 0)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(NewsModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    // Response model hatasi
                    completion(.failure(NSError(domain: "Decode Error", code: 0)))
                }
            }.resume()
        }
    }
