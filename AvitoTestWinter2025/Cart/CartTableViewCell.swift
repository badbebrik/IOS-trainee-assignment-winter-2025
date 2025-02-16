//
//  CartTableViewCell.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 16.02.2025.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func cartCell(_ cell: CartTableViewCell, didUpdateQuantity quantity: Int)
}

final class CartTableViewCell: UITableViewCell {
    weak var delegate: CartTableViewCellDelegate?

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var currentQuantity: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)

        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            minusButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            minusButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            minusButton.heightAnchor.constraint(equalToConstant: 30),

            quantityLabel.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 8),

            plusButton.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: CartItem) {
        titleLabel.text = item.product.title
        priceLabel.text = "$\(item.product.price)"
        currentQuantity = item.quantity
        quantityLabel.text = "\(currentQuantity)"
        productImageView.tintColor = .secondarySystemBackground
        if let urlString = item.product.images.first, let url = URL(string: urlString) {
            productImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            productImageView.image = UIImage(systemName: "photo")
        }
    }

    @objc private func decreaseQuantity() {
        guard currentQuantity > 1 else { return }
        currentQuantity -= 1
        quantityLabel.text = "\(currentQuantity)"
        delegate?.cartCell(self, didUpdateQuantity: currentQuantity)
    }

    @objc private func increaseQuantity() {
        currentQuantity += 1
        quantityLabel.text = "\(currentQuantity)"
        delegate?.cartCell(self, didUpdateQuantity: currentQuantity)
    }
}
