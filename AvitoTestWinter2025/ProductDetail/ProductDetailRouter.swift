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
        let galleryVC = FullScreenGalleryAssembly.assemble(with: images, initialIndex: index)
        viewController?.present(galleryVC, animated: true, completion: nil)
    }

    func shareProduct(with text: String) {
        guard let viewController = viewController else { return }
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        viewController.present(activityVC, animated: true)
    }

    func navigateToCart() {
        let cartVC = CartAssembly.assemble()
        if let nav = viewController?.navigationController {
            nav.pushViewController(cartVC, animated: true)
        } else {
            viewController?.present(cartVC, animated: true, completion: nil)
        }
    }

}
