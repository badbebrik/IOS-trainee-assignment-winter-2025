//
//  FilterButton.swift
//  AvitoTestWinter2025
//
//  Created by Виктория Серикова on 12.02.2025.
//

import UIKit

final class FilterButton: UIButton {
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        addSubview(badgeLabel)
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -4),
            badgeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBadge(count: Int) {
        badgeLabel.text = "\(count)"
        badgeLabel.isHidden = (count == 0)
    }
}
