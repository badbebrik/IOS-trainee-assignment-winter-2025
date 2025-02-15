//
//  FullScreenGalleryAssembly.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 15.02.2025.
//

import UIKit

final class FullScreenGalleryAssembly {
    static func assemble(with images: [String], initialIndex: Int) -> UIViewController {
        let galleryVC = FullScreenGalleryViewController(images: images, initialIndex: initialIndex)
        galleryVC.modalPresentationStyle = .fullScreen
        return galleryVC
    }
}
