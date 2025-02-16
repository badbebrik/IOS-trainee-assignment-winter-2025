//
//  CartViewController.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import UIKit

final class CartViewController: UIViewController {
    var presenter: CartPresenterProtocol!
    private var cartItems: [CartItem] = []
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Cart"
        configureUI()
        presenter.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearCart))
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        view.addSubview(shareButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.setEditing(true, animated: false)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -16)
        ])
    }
    
    @objc private func shareTapped() {
        presenter.didTapShare()
    }
    
    @objc private func clearCart() {
        presenter.didClearCart()
    }
}

extension CartViewController: CartViewProtocol {
    func showCartItems(_ items: [CartItem]) {
        self.cartItems = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        let item = cartItems[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = cartItems[indexPath.row]
            presenter.didRemoveCartItem(item)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.moveCartItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = cartItems[indexPath.row]
        presenter.didSelectCartItem(item)
    }
}

extension CartViewController: CartTableViewCellDelegate {
    func cartCell(_ cell: CartTableViewCell, didUpdateQuantity quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cartItem = cartItems[indexPath.row]
        presenter.didUpdateQuantity(for: cartItem, quantity: quantity)
    }
}
