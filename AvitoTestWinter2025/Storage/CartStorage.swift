//
//  CartStorage.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import Foundation

protocol CartStorageProtocol {
    func save(cartItems: [CartItem])
    func load() -> [CartItem]
}

final class CartStorage: CartStorageProtocol {
    private let key = "CartItems"

    func save(cartItems: [CartItem]) {
        if let data = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [CartItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
                let items = try? JSONDecoder().decode([CartItem].self, from: data)
        else {
            return []
        }

        return items

    }
}
