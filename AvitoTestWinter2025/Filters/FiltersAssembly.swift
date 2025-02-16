//
//  FiltersAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class FiltersAssembly {
    static func assemble(
        currentFilter: ProductFilter? = nil, delegate: FiltersModuleDelegate? = nil
    ) -> UIViewController {
        let interactor = FiltersInteractor(initialFilter: currentFilter)
        let presenter = FiltersPresenter(interactor: interactor)
        let router = FiltersRouter()

        let viewController = FiltersViewController()
        viewController.presenter = presenter

        presenter.view = viewController
        presenter.router = router
        router.viewController = viewController
        router.delegate = delegate

        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .coverVertical
        return navController
    }
}
