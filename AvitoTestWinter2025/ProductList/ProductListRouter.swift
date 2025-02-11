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

    }

    func navigateToSearchResults(with searchText: String, filter: ProductFilter?, from view: ProductListViewProtocol) {
        let searchResultsVC = SearchResultsAssembly.assemble(with: searchText, filter: filter)
        if let sourceVC = view as? UIViewController {
            sourceVC.navigationController?.pushViewController(searchResultsVC, animated: true)
        }
    }
}
