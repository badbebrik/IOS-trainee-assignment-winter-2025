//
//  CartAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import UIKit

final class CartAssembly {
    static func assemble() -> UIViewController {
        let interactor = CartInteractor(cartService: CartService.shared)
        let router = CartRouter()
        let presenter = CartPresenter(interactor: interactor, router: router)
        let viewController = CartViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
