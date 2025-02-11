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

    private var currentOffset: Int = 0
    private let limit: Int = 10
    private var isLoading: Bool = false
    private var hasMoreData: Bool = true
    private var products: [Product] = []

    private var currentFilter: ProductFilter?

    init(interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProductListPresenter: ProductListPresenterProtocol {
    func viewDidLoad() {
        resetAndLoadProducts(with: nil)
    }

    func resetAndLoadProducts(with filter: ProductFilter?) {
        currentOffset = 0
        hasMoreData = true
        products = []
        currentFilter = filter
        loadProducts()
    }

    private func loadProducts() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        interactor.fetchProducts(offset: currentOffset, limit: limit, filter: currentFilter)
    }

    func loadMoreProducts() {
        loadProducts()
    }

    func searchProducts(with query: String) {
        let filter = ProductFilter(title: query, price: nil, priceMin: nil, priceMax: nil, categoryId: nil)
        resetAndLoadProducts(with: filter)
    }

    func didSelectProduct(_ product: Product) {
        
    }

    func didFetchProducts(_ newProducts: [Product]) {
        isLoading = false
        if newProducts.count < limit {
            hasMoreData = false
        }
        products.append(contentsOf: newProducts)
        currentOffset += newProducts.count
        view?.showProducts(products)
    }

    func didFailToFetchProducts(with error: any Error) {
        isLoading = false
    }
}
