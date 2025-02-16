//
//  ProductDetailPresenter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//



final class ProductDetailPresenter: ProductDetailPresenterProtocol {

    weak var view: ProductDetailViewProtocol?
    var product: Product
    var interactor: ProductDetailInteractorProtocol

    var router: ProductDetailRouterProtocol

    init(product: Product, router: ProductDetailRouterProtocol, interactor: ProductDetailInteractorProtocol) {
        self.product = product
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {
        view?.show(product)
    }

    func shareButtonTapped() {
        let shareText = """
                Check out this product:
                \(product.title)
                Price: $\(product.price)
                \(product.description)
                """
        router.shareProduct(with: shareText)
    }

    func didSelectImage(at index: Int) {
        router.navigateToFullScreenGallery(with: product.images, startingAt: index)
    }

    func updateCartControlsForCurrentProduct() {
        let quantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        view?.updateCartControls(quantity: quantity)
    }

    func cartActionButtonTapped(for product: Product) {
        let currentQuantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        if currentQuantity > 0 {
            router.navigateToCart()
        } else {
            CartService.shared.addProduct(product, quantity: 1)
            updateCartControlsForCurrentProduct()
        }
    }

    func detailMinusButtonTapped(for product: Product) {
        let currentQuantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        if currentQuantity > 1 {
            CartService.shared.updateQuantity(for: product, quantity: currentQuantity - 1)
        } else {
            CartService.shared.removeProduct(product)
        }
        updateCartControlsForCurrentProduct()
    }

    func detailPlusButtonTapped(for product: Product) {
        let currentQuantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        CartService.shared.updateQuantity(for: product, quantity: currentQuantity + 1)
        updateCartControlsForCurrentProduct()
    }
}
