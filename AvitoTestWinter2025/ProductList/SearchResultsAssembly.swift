//
//  SearchResultsAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 12.02.2025.
//


import UIKit

final class SearchResultsAssembly {
    static func assemble(with searchText: String, filter: ProductFilter?) -> UIViewController {
        let networkService = NetworkService()
        let interactor = ProductListInteractor(networkService: networkService)
        let router = ProductListRouter()
        let presenter = ProductListPresenter(interactor: interactor, router: router)
        let viewController = ProductListViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        presenter.resetAndLoadProducts(searchText: searchText, filter: filter)
        
        viewController.title = "Результаты поиска"
        
        return viewController
    }
}
