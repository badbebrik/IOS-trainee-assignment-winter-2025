//
//  CartPresenter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

final class CartPresenter {
    weak var view: CartViewProtocol?
    var interactor: CartInteractorProtocol
    var router: CartRouterProtocol

    init(interactor: CartInteractorProtocol, router: CartRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CartPresenter: CartPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchCartItems()
    }
    
    func didTapShare() {
        let items = CartService.shared.cartItems
        let shareText = items.map { "\($0.product.title) — \($0.quantity) unit for $\(Double($0.product.price) * Double($0.quantity))" }
            .joined(separator: "\n")
        router.shareCart(with: shareText)
    }
    
    func didUpdateCart() {
        let items = CartService.shared.cartItems
        view?.showCartItems(items)
    }
    
    func didSelectCartItem(_ item: CartItem) {
        router.navigateToProductDetail(with: item.product)
    }
    
    func didRemoveCartItem(_ item: CartItem) {
        interactor.removeItem(item)
    }
    
    func didClearCart() {
        interactor.clearCart()
    }
    
    func moveCartItem(from sourceIndex: Int, to destinationIndex: Int) {
        interactor.moveItem(from: sourceIndex, to: destinationIndex)
    }
    

}
