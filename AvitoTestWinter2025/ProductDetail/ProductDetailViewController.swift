//
//  ProductDetailViewController.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 14.02.2025.
//

import UIKit

final class ProductDetailViewController: UIViewController, ProductDetailViewProtocol {
    var presenter: ProductDetailPresenterProtocol!
    private var product: Product?

    private var galleryCollectionView: UICollectionView!
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.pageIndicatorTintColor = .darkGray
        pc.currentPageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cartControlsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let cartActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to cart", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let detailMinusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let detailQuantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailPlusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureUI()
        configureCartControls()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated(notification:)), name: .cartUpdated, object: nil)
        presenter.updateCartControlsForCurrentProduct()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .cartUpdated, object: nil)
    }

    @objc private func cartUpdated(notification: Notification) {
        presenter.updateCartControlsForCurrentProduct()
    }

    private func configureNavigationBar() {
        navigationItem.title = "Product Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareTapped))
    }

    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)

        galleryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        galleryCollectionView.isPagingEnabled = true
        galleryCollectionView.showsHorizontalScrollIndicator = false
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryCell")
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(galleryCollectionView)
        view.addSubview(pageControl)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.heightAnchor.constraint(equalTo: galleryCollectionView.widthAnchor),

            pageControl.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120)
        ])
    }

    private func configureCartControls() {
        view.addSubview(cartControlsContainer)
        cartControlsContainer.addSubview(cartActionButton)
        cartControlsContainer.addSubview(detailMinusButton)
        cartControlsContainer.addSubview(detailQuantityLabel)
        cartControlsContainer.addSubview(detailPlusButton)

        NSLayoutConstraint.activate([
            cartControlsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cartControlsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cartControlsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartControlsContainer.heightAnchor.constraint(equalToConstant: 60),

            cartActionButton.leadingAnchor.constraint(equalTo: cartControlsContainer.leadingAnchor),
            cartActionButton.trailingAnchor.constraint(equalTo: cartControlsContainer.trailingAnchor),
            cartActionButton.topAnchor.constraint(equalTo: cartControlsContainer.topAnchor, constant: 8),
            cartActionButton.heightAnchor.constraint(equalToConstant: 44),

            detailMinusButton.leadingAnchor.constraint(equalTo: cartControlsContainer.leadingAnchor, constant: 16),
            detailMinusButton.topAnchor.constraint(equalTo: cartControlsContainer.topAnchor, constant: 8),
            detailMinusButton.widthAnchor.constraint(equalToConstant: 30),
            detailMinusButton.heightAnchor.constraint(equalToConstant: 44),

            detailQuantityLabel.leadingAnchor.constraint(equalTo: detailMinusButton.trailingAnchor, constant: 8),
            detailQuantityLabel.centerYAnchor.constraint(equalTo: detailMinusButton.centerYAnchor),
            detailQuantityLabel.widthAnchor.constraint(equalToConstant: 40),

            detailPlusButton.leadingAnchor.constraint(equalTo: detailQuantityLabel.trailingAnchor, constant: 8),
            detailPlusButton.topAnchor.constraint(equalTo: detailMinusButton.topAnchor),
            detailPlusButton.widthAnchor.constraint(equalToConstant: 30),
            detailPlusButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        detailMinusButton.isHidden = true
        detailQuantityLabel.isHidden = true
        detailPlusButton.isHidden = true

        cartActionButton.addTarget(self, action: #selector(cartActionButtonTapped), for: .touchUpInside)
        detailMinusButton.addTarget(self, action: #selector(detailMinusButtonTapped), for: .touchUpInside)
        detailPlusButton.addTarget(self, action: #selector(detailPlusButtonTapped), for: .touchUpInside)
    }

    func show(_ product: Product) {
        self.product = product
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        descriptionLabel.text = product.description
        pageControl.numberOfPages = product.images.count
        galleryCollectionView.reloadData()

        presenter.updateCartControlsForCurrentProduct()
    }

    func updateCartControls(quantity: Int) {
        if quantity > 0 {
            cartActionButton.setTitle("To Cart", for: .normal)
            detailMinusButton.isHidden = false
            detailQuantityLabel.isHidden = false
            detailPlusButton.isHidden = false
            detailQuantityLabel.text = "\(quantity)"
        } else {
            cartActionButton.setTitle("Add to cart", for: .normal)
            detailMinusButton.isHidden = true
            detailQuantityLabel.isHidden = true
            detailPlusButton.isHidden = true
        }
    }

    @objc private func shareTapped() {
        presenter.shareButtonTapped()
    }

    @objc private func cartActionButtonTapped() {
        guard let product = product else { return }
        presenter.cartActionButtonTapped(for: product)
    }

    @objc private func detailMinusButtonTapped() {
        guard let product = product else { return }
        presenter.detailMinusButtonTapped(for: product)
    }

    @objc private func detailPlusButtonTapped() {
        guard let product = product else { return }
        presenter.detailPlusButtonTapped(for: product)
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let imageUrl = product?.images[indexPath.item] {
            cell.configure(with: imageUrl)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectImage(at: indexPath.item)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}

// MARK: - ProductCollectionViewCellDelegate
extension ProductListViewController: ProductCollectionViewCellDelegate {
    func productCellDidTapAddToCart(_ cell: ProductCollectionViewCell, product: Product) {
        presenter?.didTapAddToCart(for: product)
    }

    func productCell(_ cell: ProductCollectionViewCell, didTapMinusFor product: Product) {
        presenter?.didTapMinus(for: product)
    }

    func productCell(_ cell: ProductCollectionViewCell, didTapPlusFor product: Product) {
        presenter?.didTapPlus(for: product)
    }
}
