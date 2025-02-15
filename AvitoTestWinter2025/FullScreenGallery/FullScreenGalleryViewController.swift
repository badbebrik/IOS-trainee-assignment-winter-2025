//
//  FullScreenGalleryViewController.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 15.02.2025.
//

import UIKit
import Kingfisher

final class FullScreenGalleryViewController: UIViewController {
    private var images: [String] = []
    private var initialIndex: Int = 0

    private var collectionView: UICollectionView!
    private let closeButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Close", for: .normal)
       button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()

    init(images: [String], initialIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.images = images
        self.initialIndex = initialIndex
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = view.bounds.size
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ZoomableGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "ZoomableGalleryCell")
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.layoutIfNeeded()
        let initialIndexPath = IndexPath(item: initialIndex, section: 0)
        collectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
    }

    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension FullScreenGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZoomableGalleryCell", for: indexPath) as? ZoomableGalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: images[indexPath.item])
        return cell
    }

}
