//
//  CartProtocols.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

// MARK: View
protocol CartViewProtocol: AnyObject {
    func showCartItems(_ items: [CartItem])
}

// MARK: Presenter
protocol CartPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapShare()
    func didUpdateCart()
    func didSelectCartItem(_ item: CartItem)
    func didRemoveCartItem(_ item: CartItem)
    func didClearCart()
    func moveCartItem(from sourceIndex: Int, to destinationIndex: Int)
    func didUpdateQuantity(for cartItem: CartItem, quantity: Int)
}

// MARK: Interactor
protocol CartInteractorProtocol: AnyObject {
    func fetchCartItems()
    func removeItem(_ item: CartItem)
    func clearCart()
    func moveItem(from sourceIndex: Int, to destinationIndex: Int)
    func updateQuantity(for cartItem: CartItem, quantity: Int)

}

// MARK: Router
protocol CartRouterProtocol: AnyObject {
    func navigateToProductDetail(with product: Product)
    func shareCart(with text: String)
}
