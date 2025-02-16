//
//  FiltersRouter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class FiltersRouter: FiltersRouterProtocol {
    weak var viewController: UIViewController?
    weak var delegate: FiltersModuleDelegate?
    
    func dismissFilters(with appliedFilter: ProductFilter?) {
        viewController?.dismiss(animated: true, completion: { [weak self] in
            if let filter = appliedFilter {
                self?.delegate?.filtersModule(didApply: filter)
            } else {
                self?.delegate?.filtersModuleDidCancel()
            }
        })
    }
}
