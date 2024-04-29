//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

class CharacterListCell: UITableViewCell {
    struct Model: Equatable {
        let imageUrlString: String
        let name: String
        let id: Int
    }
    
    private struct LayoutConstants {
        static let spacing: CGFloat = 8
        static let padding = 10
        static let cellPadding = ConstraintsConstants(constant: 10)
        static let imageSize: CGFloat = 50
        static let cornerRadius: CGFloat = 15
        static let imageCornerRadius: CGFloat = 5
    }

    // MARK: Views
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = LayoutConstants.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "userIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageSize).isActive = true

        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGreenRM

        return label
    }()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            icon,
            titleLabel
        ])
        stack.axis = .horizontal
        stack.spacing = LayoutConstants.spacing

        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    // MARK: Configuration

    func configure(with model: Model) {
        backgroundColor = .clear
        selectionStyle = .none
        
        if let url = URL(string: model.imageUrlString) {
            Task {
                do {
                    try await icon.downloadImage(from: url)
                } catch {
                    print(error)
                }
            }
        }
        titleLabel.text = model.name
        
        container.fit(to: containerView,
                      with: ConstraintsConstants(constant: LayoutConstants.spacing))
        containerView.fit(to: contentView, with: LayoutConstants.cellPadding)
    }
}
