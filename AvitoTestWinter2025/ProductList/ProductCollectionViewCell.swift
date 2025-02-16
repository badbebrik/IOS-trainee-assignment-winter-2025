//
//  ProductCollectionViewCell.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import UIKit

protocol ProductCollectionViewCellDelegate: AnyObject {
    func productCellDidTapAddToCart(_ cell: ProductCollectionViewCell, product: Product)
    func productCell(_ cell: ProductCollectionViewCell, didTapMinusFor product: Product)
    func productCell(_ cell: ProductCollectionViewCell, didTapPlusFor product: Product)
}

final class ProductCollectionViewCell: UICollectionViewCell {
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to cart", for: .normal)
        return button
    }()
    
    private let quantityContainerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        return button
    }()
    
    weak var delegate: ProductCollectionViewCellDelegate?
    private var currentProduct: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(quantityContainerView)
        quantityContainerView.addSubview(minusButton)
        quantityContainerView.addSubview(quantityLabel)
        quantityContainerView.addSubview(plusButton)
        
        [productImageView, titleLabel, priceLabel, addToCartButton, quantityContainerView, minusButton, quantityLabel, plusButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            addToCartButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            addToCartButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            
            quantityContainerView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            quantityContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            quantityContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            quantityContainerView.heightAnchor.constraint(equalToConstant: 30),
            quantityContainerView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            
            minusButton.leadingAnchor.constraint(equalTo: quantityContainerView.leadingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            
            quantityLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 5),
            quantityLabel.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            
            plusButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 5),
            plusButton.trailingAnchor.constraint(equalTo: quantityContainerView.trailingAnchor),
            plusButton.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.kf.cancelDownloadTask()
        productImageView.image = UIImage(systemName: "photo")
        productImageView.tintColor = .secondarySystemBackground
        titleLabel.text = nil
        priceLabel.text = nil
        addToCartButton.isHidden = false
        quantityContainerView.isHidden = true
    }
    
    func configure(with product: Product, cartQuantity: Int?) {
        self.currentProduct = product
        productImageView.tintColor = .secondarySystemBackground
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        
        if let quantity = cartQuantity, quantity > 0 {
            quantityLabel.text = "\(quantity)"
            addToCartButton.isHidden = true
            quantityContainerView.isHidden = false
        } else {
            addToCartButton.isHidden = false
            quantityContainerView.isHidden = true
        }
        
        if let urlString = product.images.first, let url = URL(string: urlString) {
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [.transition(.fade(0.2))]
            )
        } else {
            productImageView.image = UIImage(systemName: "photo")?.withTintColor(.secondarySystemBackground)
        }
    }
    
    @objc private func addToCartButtonTapped() {
        guard let product = currentProduct else { return }
        delegate?.productCellDidTapAddToCart(self, product: product)
    }
    
    @objc private func minusButtonTapped() {
        guard let product = currentProduct else { return }
        delegate?.productCell(self, didTapMinusFor: product)
    }
    
    @objc private func plusButtonTapped() {
        guard let product = currentProduct else { return }
        delegate?.productCell(self, didTapPlusFor: product)
    }
}
