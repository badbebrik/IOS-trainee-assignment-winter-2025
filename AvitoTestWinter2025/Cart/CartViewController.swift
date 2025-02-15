//
//  CartViewController.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import UIKit

final class CartViewController: UIViewController, CartViewProtocol {
    var presenter: CartPresenterProtocol!
    private var cartItems: [CartItem] = []


    override func viewDidLoad() {
        <#code#>
    }

    func showCartItems(_ items: [CartItem]) {
        <#code#>
    }
}
