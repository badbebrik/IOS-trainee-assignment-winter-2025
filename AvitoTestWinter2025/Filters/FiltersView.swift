//
//  FiltersView.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class FiltersViewController: UIViewController, FiltersViewProtocol {

    var presenter: FiltersPresenterProtocol!

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

    private let categoryIdTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "ID категории"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        return tf
    }()

    private let resetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Сбросить", for: .normal)
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
        navigationItem.title = "Фильтры"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Применить", style: .done, target: self, action: #selector(applyTapped))
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        [priceMinTextField, priceMaxTextField, categoryIdTextField, resetButton].forEach { contentStackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    private func setupActions() {
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }

    @objc private func applyTapped() {
        presenter.applyButtonTapped(with: priceMinTextField.text,
                                    priceMax: priceMaxTextField.text,
                                    categoryId: categoryIdTextField.text)
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
        categoryIdTextField.text = filter.categoryId.map { "\($0)" } ?? ""
    }
}
