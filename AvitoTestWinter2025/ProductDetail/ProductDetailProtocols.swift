//
//  ProductDetailProtocols.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

// MARK: - View Protocol
protocol ProductDetailViewProtocol: AnyObject {
    func show(_ product: Product)
    func updateCartControls(quantity: Int)
}

// MARK: - Presenter Protocol
protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func shareButtonTapped()
    func didSelectImage(at: Int)
    func updateCartControlsForCurrentProduct()
    func cartActionButtonTapped(for product: Product)
    func detailMinusButtonTapped(for product: Product)
    func detailPlusButtonTapped(for product: Product)
}

// MARK: - Interactor Protocol
protocol ProductDetailInteractorProtocol: AnyObject {}

// MARK: - Router Protocol
protocol ProductDetailRouterProtocol: AnyObject {
    func navigateToFullScreenGallery(with images: [String], startingAt index: Int)
    func shareProduct(with text: String)
    func navigateToCart()
}
