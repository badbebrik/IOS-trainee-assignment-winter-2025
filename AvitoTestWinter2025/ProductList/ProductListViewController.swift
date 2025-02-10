//
//  ProductListView.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import UIKit

final class ProductListViewController: UIViewController, ProductListViewProtocol {
    var presenter: ProductListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    func showProducts(_ products: [Product]) {

    }

    func showEmptyState() {
        
    }

}
