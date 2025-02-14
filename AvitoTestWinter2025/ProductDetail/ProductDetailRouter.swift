//
//  ProductDetailRouter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class ProductDetailRouter: ProductDetailRouterProtocol {

    weak var viewController: UIViewController?

    func navigateToFullScreenGallery(with images: [String], startingAt index: Int) {
        
    }
    
    func shareProduct(with text: String) {
        guard let vc = viewController else { return }
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        vc.present(activityVC, animated: true)
    }

}
