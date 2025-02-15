//
//  ProductListView.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import UIKit

final class ProductListViewController: UIViewController, ProductListViewProtocol {
    var presenter: ProductListPresenterProtocol?

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Введите название товара"
        searchBar.searchTextField.clearButtonMode = .whileEditing
        return searchBar
    }()

    private lazy var filterButton: FilterButton = {
        let button = FilterButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()

    private var products: [Product] = []
    private var collectionView: UICollectionView!
    private var historyTableView: UITableView!
    private var searchHistory: [String] = []
    var currentFilter: ProductFilter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureSearchHistoryTableView()
        searchBar.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        presenter?.viewDidLoad()
    }

    private func configureNavigationBar() {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = searchBar

        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let itemWidth = (view.frame.width - 3 * padding) / 2.0
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground


        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }

    private func configureSearchHistoryTableView() {
        historyTableView = UITableView()
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.isHidden = true
        historyTableView.tableFooterView = UIView()
        view.addSubview(historyTableView)
        historyTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func showProducts(_ products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func presentSearchHistory() {
        searchHistory = SearchHistoryService.shared.history
        historyTableView.reloadData()
        historyTableView.isHidden = searchHistory.isEmpty
        collectionView.isHidden = true
    }

    private func hideSearchHistory() {
        historyTableView.isHidden = true
        collectionView.isHidden = false
    }

    func showEmptyState() {

    }

    @objc private func filterButtonTapped() {
        let filtersVC = FiltersAssembly.assemble(currentFilter: self.currentFilter, delegate: self)
        present(filtersVC, animated: true, completion: nil)
    }

    func updateFilterBadge(count: Int) {
        filterButton.updateBadge(count: count)
    }

}

// MARK: - UISearchBarDelegate
extension ProductListViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presentSearchHistory()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideSearchHistory()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter?.resetAndLoadProducts(searchText: "", filter: currentFilter)
        }
        presentSearchHistory()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideSearchHistory()
        guard let text = searchBar.text else { return }
        SearchHistoryService.shared.add(query: text)
        presenter?.resetAndLoadProducts(searchText: text, filter: currentFilter)
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuery = searchHistory[indexPath.row]
        searchBar.text = selectedQuery
        hideSearchHistory()
        presenter?.resetAndLoadProducts(searchText: selectedQuery, filter: currentFilter)
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        presenter?.didSelectProduct(product)
    }
}

// MARK: - UIScrollViewDelegate
extension ProductListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight - 100 {
            presenter?.loadMoreProducts()
        }
    }
}

extension ProductListViewController: FiltersModuleDelegate {
    func filtersModule(didApply filter: ProductFilter) {
        self.currentFilter = filter
        presenter?.resetAndLoadProducts(searchText: nil, filter: filter)
        updateFilterBadge(count: filter.activeFiltersCount)
    }

    func filtersModuleDidCancel() {

    }
}
