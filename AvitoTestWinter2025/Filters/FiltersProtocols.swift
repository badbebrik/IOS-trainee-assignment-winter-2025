//
//  FiltersProtocols.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

// MARK: - View Protocol
protocol FiltersViewProtocol: AnyObject {
    func display(filter: ProductFilter)
    func displayCategories(_ categories: [Category])
    func displayError(_ error: Error)
}

// MARK: - Presenter Protocol
protocol FiltersPresenterProtocol: AnyObject {
    func viewDidLoad()
    func applyButtonTapped(with priceMin: String?, priceMax: String?, categoryId: String?)
    func resetButtonTapped()
    func cancelButtonTapped()
}

// MARK: - Interactor Protocol
protocol FiltersInteractorProtocol: AnyObject {
    var currentFilter: ProductFilter { get }
    func getCurrentFilter() -> ProductFilter
    func updateFilter(_ filter: ProductFilter)
    func resetFilter()
    func loadCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

// MARK: - Router Protocol
protocol FiltersRouterProtocol: AnyObject {
    func dismissFilters(with appliedFilter: ProductFilter?)
}

// MARK: - Module Delegate Protocol
protocol FiltersModuleDelegate: AnyObject {
    func filtersModule(didApply filter: ProductFilter)
    func filtersModuleDidCancel()
}
