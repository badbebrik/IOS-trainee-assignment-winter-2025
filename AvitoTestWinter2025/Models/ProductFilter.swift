//
//  ProductFilter.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 12.02.2025.
//

struct ProductFilter {
    var title: String?
    var price: Int?
    var priceMin: Int?
    var priceMax: Int?
    var categoryId: Int?
    
    var activeFiltersCount: Int {
        var count = 0
        if price != nil { count += 1 }
        if priceMin != nil { count += 1 }
        if priceMax != nil { count += 1 }
        if categoryId != nil { count += 1 }
        return count
    }
}
