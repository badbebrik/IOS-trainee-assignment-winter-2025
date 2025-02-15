//
//  ProductListRouter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import UIKit

final class ProductListRouter: ProductListRouterProtocol {
    weak var viewController: UIViewController?

    func navigateToProductDetail(with product: Product, from view: any ProductListViewProtocol) {
        let detailVC = ProductDetailAssembly.assemble(with: product)
        if let sourceVC = view as? UIViewController, let nav = sourceVC.navigationController {
            nav.pushViewController(detailVC, animated: true)
        } else {
            viewController?.present(detailVC, animated: true, completion: nil)
        }
    }
}
