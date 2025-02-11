//
//  NetworkService.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products?offset=\(offset)&limit=\(limit)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
