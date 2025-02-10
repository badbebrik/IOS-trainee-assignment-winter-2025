//
//  ProductListPresenter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

final class ProductListPresenter {
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorProtocol
    var router: ProductListRouterProtocol

    init(interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProductListPresenter: ProductListPresenterProtocol {
    func viewDidLoad() {

    }
    
    func searchProducts(with query: String) {

    }
    
    func didSelectProduct(_ product: Product) {

    }
}
