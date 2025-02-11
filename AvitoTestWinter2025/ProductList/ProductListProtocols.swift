//
//  ProductListProtocols.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

// MARK: View protocol
protocol ProductListViewProtocol: AnyObject {
    func showProducts(_ products: [Product])
    func showEmptyState()
}

// MARK: Presenter protocol
protocol ProductListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func searchProducts(with query: String)
    func didSelectProduct(_ product: Product)
    func didFetchProducts(_ products: [Product])
    func didFailToFetchProducts(with error: Error)
    func loadMoreProducts()
}

// MARK: Interactor protocol
protocol ProductListInteractorProtocol: AnyObject {
    func fetchProducts(offset: Int, limit: Int, filter: ProductFilter?)
}

// MARK: Router protocol
protocol ProductListRouterProtocol: AnyObject {
    func navigateToProductDetail(with product: Product, from view: ProductListViewProtocol)
}
