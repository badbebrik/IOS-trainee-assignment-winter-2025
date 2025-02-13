//
//  NetworkService.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchProducts(
        offset: Int?,
        limit: Int?,
        searchText: String?,
        filter: ProductFilter?,
        completion: @escaping (Result<[Product], Error>) -> Void
    )
}

final class NetworkService: NetworkServiceProtocol {
    func fetchProducts(
        offset: Int? = nil,
        limit: Int? = nil,
        searchText: String? = nil,
        filter: ProductFilter? = nil,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.escuelajs.co"
        components.path = "/api/v1/products"

        var queryItems = [URLQueryItem]()

        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }

        if let text = searchText, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            queryItems.append(URLQueryItem(name: "title", value: text))
        }

        if let filter = filter {
            if let price = filter.price {
                queryItems.append(URLQueryItem(name: "price", value: "\(price)"))
            }
            if let priceMin = filter.priceMin {
                queryItems.append(URLQueryItem(name: "price_min", value: "\(priceMin)"))
            }
            if let priceMax = filter.priceMax {
                queryItems.append(URLQueryItem(name: "price_max", value: "\(priceMax)"))
            }
            if let categoryId = filter.categoryId {
                queryItems.append(URLQueryItem(name: "categoryId", value: "\(categoryId)"))
            }
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print(url)
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
