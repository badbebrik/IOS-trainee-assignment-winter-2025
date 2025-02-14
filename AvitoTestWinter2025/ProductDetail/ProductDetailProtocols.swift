//
//  ProductDetailProtocols.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

// MARK: - View Protocol
protocol ProductDetailViewProtocol: AnyObject {
    func show(_ product: Product)
}

// MARK: - Presenter Protocol
protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: - Interactor Protocol
protocol ProductDetailProtocolsInteractorProtocol: AnyObject {}

// MARK: - Router Protocol
protocol ProductDetailRouterProtocol: AnyObject {
    func navigateToFullScreenGallery(with images: [String], startingAt index: Int)
    func shareProduct(with text: String)
}
