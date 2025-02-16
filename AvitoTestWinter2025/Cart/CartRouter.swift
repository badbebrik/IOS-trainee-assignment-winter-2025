//
//  CartRouter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import UIKit

final class CartRouter: CartRouterProtocol {
    
    weak var viewController: UIViewController?

    func navigateToProductDetail(with product: Product) {
        let detailVC = ProductDetailAssembly.assemble(with: product)
        if let nav = viewController?.navigationController {
            nav.pushViewController(detailVC, animated: true)
        } else {
            viewController?.present(detailVC, animated: true, completion: nil)
        }
    }

    func shareCart(with text: String) {
        guard let vc = viewController else { return }
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        vc.present(activityVC, animated: true)
    }
}
