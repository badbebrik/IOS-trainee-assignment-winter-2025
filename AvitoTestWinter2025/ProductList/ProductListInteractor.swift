//
//  ProductListInteractor.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

final class ProductListInteractor: ProductListInteractorProtocol {
    weak var presenter: ProductListPresenterProtocol?
    let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchProducts(offset: Int, limit: Int) {
        networkService.fetchProducts(offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let products):
                self?.presenter?.didFetchProducts(products)
            case .failure(let error):
                self?.presenter?.didFailToFetchProducts(with: error)
            }
        }
    }
}
