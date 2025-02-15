//
//  CartInteractor.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import Foundation

final class CartInteractor: CartInteractorProtocol {

    weak var presenter: CartPresenterProtocol?
    private let cartService: CartService

    init(cartService: CartService) {
        self.cartService = cartService
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func fetchCartItems() {
        presenter?.didUpdateCart()
    }

    func removeItem(_ item: CartItem) {
        cartService.removeProduct(item.product)
    }

    func clearCart() {
        cartService.clearCart()
    }

    func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        cartService.moveItem(from: sourceIndex, to: destinationIndex)
    }

    func updateQuantity(for cartItem: CartItem, quantity: Int) {
        cartService.updateQuantity(for: cartItem.product, quantity: quantity)
    }

    @objc private func cartUpdated() {
        presenter?.didUpdateCart()
    }
}
