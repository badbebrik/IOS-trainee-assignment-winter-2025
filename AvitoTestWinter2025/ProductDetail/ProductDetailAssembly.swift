//
//  ProductDetailAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class ProductDetailAssembly {
    static func assemble(with product: Product) -> UIViewController {
        let viewController = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()
        router.viewController = viewController
        let presenter = ProductDetailPresenter(product: product, router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
