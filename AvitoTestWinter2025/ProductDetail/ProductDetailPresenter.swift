//
//  ProductDetailPresenter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//



final class ProductDetailPresenter: ProductDetailPresenterProtocol {

    weak var view: ProductDetailViewProtocol?
    var product: Product

    init(product: Product) {
        self.product = product
    }

    func viewDidLoad() {
        view?.show(product)
    }
}
