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
    private var currentSearchText: String?

    init(interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProductListPresenter: ProductListPresenterProtocol {
    func viewDidLoad() {
        resetAndLoadProducts(searchText: nil, filter: nil)
    }

    func resetAndLoadProducts(searchText: String?, filter: ProductFilter?) {
        currentOffset = 0
        hasMoreData = true
        products = []
        currentSearchText = searchText
        currentFilter = filter
        loadProducts()
    }

    private func loadProducts() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        interactor.fetchProducts(
            offset: currentOffset,
            limit: limit,
            searchText: currentSearchText,
            filter: currentFilter
        )
    }

    func loadMoreProducts() {
        loadProducts()
    }

    func searchProducts(with query: String) {
        resetAndLoadProducts(searchText: query, filter: currentFilter)
    }

    func didSelectProduct(_ product: Product) {
        router.navigateToProductDetail(with: product, from: view!)
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

    func didTapAddToCart(for product: Product) {
        CartService.shared.addProduct(product, quantity: 1)
        view?.updateProductCell(for: product)
    }

    func didTapMinus(for product: Product) {
        let currentQuantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        if currentQuantity > 1 {
            CartService.shared.updateQuantity(for: product, quantity: currentQuantity - 1)
        } else {
            CartService.shared.removeProduct(product)
        }
        view?.updateProductCell(for: product)
    }

    func didTapPlus(for product: Product) {
        let currentQuantity = CartService.shared.cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
        CartService.shared.updateQuantity(for: product, quantity: currentQuantity + 1)
        view?.updateProductCell(for: product)
    }
}
