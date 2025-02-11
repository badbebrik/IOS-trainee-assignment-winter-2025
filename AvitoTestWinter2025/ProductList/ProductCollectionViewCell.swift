//
//  ProductCollectionViewCell.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 11.02.2025.
//

import UIKit

final class ProductCollectionViewCell : UICollectionViewCell {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: Product) {
        titleLabel.text = product.title

        if product.images.isEmpty {
            productImageView.image = UIImage(systemName: "placeholder-photo")
            return
        }

        let urlStr = product.images[0]

        guard let url = URL(string: urlStr) else {
            productImageView.image = UIImage(systemName: "placeholder-photo")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self?.productImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self?.productImageView.image = UIImage(systemName: "placeholder-photo")
                }
            }
        }.resume()

    }
}
