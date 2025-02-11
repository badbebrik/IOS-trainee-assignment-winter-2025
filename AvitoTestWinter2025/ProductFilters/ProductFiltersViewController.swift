//
//  ProductFiltersViewController.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 12.02.2025.
//

import UIKit

protocol ProductFiltersViewControllerDelegate: AnyObject {
    func filtersViewController(_ vc: ProductFiltersViewController, didApplyFilter filter: ProductFilter)
    func filtersViewControllerDidCancel(_ vc: ProductFiltersViewController)
}

final class ProductFiltersViewController: UIViewController {
    weak var delegate: ProductFiltersViewControllerDelegate?

    private let priceMinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Цена от"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    private let priceMaxTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Цена до"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    private let categoryIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ID категории"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Применить", for: .normal)
        return button
    }()

    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Отмена", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [priceMinTextField, priceMaxTextField, categoryIdTextField, applyButton, cancelButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

    @objc private func applyButtonTapped() {
        let priceMin = Int(priceMinTextField.text ?? "")
        let priceMax = Int(priceMaxTextField.text ?? "")
        let categoryId = Int(categoryIdTextField.text ?? "")

        let filter = ProductFilter(title: title, price: nil, priceMin: priceMin, priceMax: priceMax, categoryId: categoryId)
        delegate?.filtersViewController(self, didApplyFilter: filter)
    }

    @objc private func cancelButtonTapped() {
        delegate?.filtersViewControllerDidCancel(self)
    }
}
