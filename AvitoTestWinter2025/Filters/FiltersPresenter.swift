//
//  FiltersPresenter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

final class FiltersPresenter: FiltersPresenterProtocol {
    weak var view: FiltersViewProtocol?
    var interactor: FiltersInteractorProtocol
    var router: FiltersRouterProtocol?

    init(interactor: FiltersInteractorProtocol) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        view?.display(filter: interactor.getCurrentFilter())
    }

    func applyButtonTapped(with priceMin: String?, priceMax: String?, categoryId: String?) {
        let priceMinValue = Int(priceMin ?? "")
        let priceMaxValue = Int(priceMax ?? "")
        let categoryIdValue = Int(categoryId ?? "")

        let newFilter = ProductFilter(
            title: nil,
            price: nil,
            priceMin: priceMinValue,
            priceMax: priceMaxValue,
            categoryId: categoryIdValue
        )
        interactor.updateFilter(newFilter)
        router?.dismissFilters(with: newFilter)
    }

    func resetButtonTapped() {
        interactor.resetFilter()
        router?.dismissFilters(with: interactor.getCurrentFilter())
    }

    func cancelButtonTapped() {
        router?.dismissFilters(with: nil)
    }
}

