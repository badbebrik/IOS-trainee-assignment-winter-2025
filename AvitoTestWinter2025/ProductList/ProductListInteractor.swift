//
//  ProductListInteractor.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

final class ProductListInteractor: ProductListInteractorProtocol {
    weak var presenter: ProductListPresenterProtocol?
    
    func fetchProducts() {

    }
    
    func didFetchProducts(_ products: [Product]) {

    }
    
    func didFailToFetchProducts(with error: any Error) {

    }
}
