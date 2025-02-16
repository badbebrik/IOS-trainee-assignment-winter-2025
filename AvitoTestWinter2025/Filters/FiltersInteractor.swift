//
//  FiltersInteractor.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

final class FiltersInteractor: FiltersInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    var categories: [Category] = []
    private static var savedFilter: ProductFilter?

    private(set) var currentFilter: ProductFilter

    init(initialFilter: ProductFilter?, networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
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

    func loadCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        networkService.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
