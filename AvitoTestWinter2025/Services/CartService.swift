//
//  CartService.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import Foundation

extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}

final class CartService {
    static let shared = CartService(storage: CartStorage())
    private let storage: CartStorageProtocol

    private(set) var cartItems: [CartItem] = [] {
        didSet {
            storage.save(cartItems: cartItems)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }

    init(storage: CartStorageProtocol) {
        self.storage = storage
        self.cartItems = storage.load()
    }

    func addProduct(_ product: Product, quantity: Int = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }

    func updateQuantity(for product: Product, quantity: Int) {
        if let index = cartItems.firstIndex(where: {$0.product.id == product.id}) {
            cartItems[index].quantity = quantity
        }
    }

    func removeProduct(_ product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }

    func clearCart() {
        cartItems.removeAll()
    }

    func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex,
                sourceIndex < cartItems.count,
                destinationIndex < cartItems.count
        else { return }
        let item = cartItems.remove(at: sourceIndex)
        cartItems.insert(item, at: destinationIndex)
    }

}
