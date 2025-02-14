//
//  SearchHistoryService.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import Foundation

final class SearchHistoryService {
    static let shared = SearchHistoryService()

    private let key = "searchHistory"
    private let maxItems = 5

    private init() {}

    var history: [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func add(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        var currentHistory = history

        if let existingIndex = currentHistory.firstIndex(of: trimmedQuery) {
            currentHistory.remove(at: existingIndex)
        }

        currentHistory.insert(trimmedQuery, at: 0)

        if currentHistory.count > maxItems {
            currentHistory = Array(currentHistory.prefix(maxItems))
        }

        UserDefaults.standard.set(currentHistory, forKey: key)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
