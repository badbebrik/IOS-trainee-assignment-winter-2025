//
//  CartItem.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import Foundation

struct CartItem: Codable, Equatable {
    let product: Product
    var quantity: Int
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
