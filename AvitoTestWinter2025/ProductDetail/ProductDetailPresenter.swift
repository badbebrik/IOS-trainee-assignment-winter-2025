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
}
