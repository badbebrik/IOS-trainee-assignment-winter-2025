//
//  Product.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]

    static func mock() -> Product {
        return Product(id: 555, title: "Boots", price: 120, description: "Warm", category: .init(id: 0, name: "", image: ""), images: ["https://avatars.mds.yandex.net/i?id=167fd8b0b0c82abef7aacddb2e7c8498_l-5112218-images-thumbs&n=13",
                                                                                                                                       "https://respect-shoes.ru/upload/medialibrary/c3f/c3fd6e8ad44eeacab7bac686e7285624.jpg"])
    }
}


