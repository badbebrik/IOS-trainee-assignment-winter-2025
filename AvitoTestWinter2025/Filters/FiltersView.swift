//
//  FiltersView.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class FiltersViewController: UIViewController, FiltersViewProtocol {
    
    var presenter: FiltersPresenterProtocol!
    
    private var categoriesCollectionView: UICollectionView!
    private var categories: [Category] = []
    private var selectedCategoryId: Int?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let categoriesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceMinTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Цена от"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let priceMaxTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Цена до"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        return tf
    }()
    
    
    private let resetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Clear", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        btn.setTitleColor(.systemRed, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupUI()
        setupActions()
        presenter.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Filters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(applyTapped))
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 8
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoriesCollectionView.backgroundColor = .clear
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        contentStackView.addArrangedSubview(categoriesTitleLabel)
        contentStackView.addArrangedSubview(categoriesCollectionView)
        contentStackView.addArrangedSubview(priceMinTextField)
        contentStackView.addArrangedSubview(priceMaxTextField)
        contentStackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -20),
            
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupActions() {
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }
    
    @objc private func applyTapped() {
        presenter.applyButtonTapped(with: priceMinTextField.text,
                                    priceMax: priceMaxTextField.text,
                                    categoryId: selectedCategoryId?.description)
    }
    
    @objc private func resetTapped() {
        presenter.resetButtonTapped()
    }
    
    @objc private func cancelTapped() {
        presenter.cancelButtonTapped()
    }
    
    func display(filter: ProductFilter) {
        priceMinTextField.text = filter.priceMin.map { "\($0)" } ?? ""
        priceMaxTextField.text = filter.priceMax.map { "\($0)" } ?? ""
        if let catId = filter.categoryId {
            selectedCategoryId = catId
        } else {
            selectedCategoryId = nil
        }
        categoriesCollectionView.reloadData()    }
    
    func displayCategories(_ categories: [Category]) {
        self.categories = categories
        self.categoriesCollectionView.reloadData()
    }
    
    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension FiltersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.item]
        let isSelected = (category.id == selectedCategoryId)
        cell.configure(with: category, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        if selectedCategoryId == category.id {
            selectedCategoryId = nil
        } else {
            selectedCategoryId = category.id
        }
        collectionView.reloadData()
    }
}

