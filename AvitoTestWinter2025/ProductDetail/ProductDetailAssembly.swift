//
//  ProductDetailAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class ProductDetailAssembly {
    static func assemble(with product: Product) -> UIViewController {
        let presenter = ProductDetailPresenter(product: product)
        let viewController = ProductDetailViewController()
        viewController.presenter = presenter
        presenter.view = viewController

        let router = ProductDetailRouter()
        router.viewController = viewController

        return viewController
    }
}
