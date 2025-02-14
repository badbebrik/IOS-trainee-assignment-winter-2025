//
//  FiltersInteractor.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

final class FiltersInteractor: FiltersInteractorProtocol {
    private static var savedFilter: ProductFilter?

    private(set) var currentFilter: ProductFilter

    init(initialFilter: ProductFilter?) {
        if let filter = initialFilter {
            self.currentFilter = filter
            FiltersInteractor.savedFilter = filter
        } else if let saved = FiltersInteractor.savedFilter {
            self.currentFilter = saved
        } else {
            self.currentFilter = ProductFilter(title: nil, price: nil, priceMin: nil, priceMax: nil, categoryId: nil)
        }
    }

    func getCurrentFilter() -> ProductFilter {
        return currentFilter
    }

    func updateFilter(_ filter: ProductFilter) {
        currentFilter = filter
        FiltersInteractor.savedFilter = filter
    }

    func resetFilter() {
        currentFilter = ProductFilter(title: nil, price: nil, priceMin: nil, priceMax: nil, categoryId: nil)
        FiltersInteractor.savedFilter = currentFilter
    }
}
