//
//  APIHandler.swift
//  AssetoneDemo
//
//  Created by DEVM-SUNDAR on 06/03/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed(Error)
}

class APIHandler {
    static let shared = APIHandler()

    private init() {} // Singleton instance

    func fetchData<T: Codable>(from urlString: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
