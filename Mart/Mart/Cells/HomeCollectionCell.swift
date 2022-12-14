//
//  HomeCollectionCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 12/09/22.
//

import UIKit

protocol HomeViewCellDelegate: AnyObject {
    func didTapFavorite(id: String, isFavorite: Bool)
}

class HomeCollectionCell: UICollectionViewCell, ViewCodable {
    
    static let identifier = "HomeCollectionCell"
    
    weak var delegate: HomeViewCellDelegate?
    
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.backgroundColor = .lightGray
        return image
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xA0A4A8)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontStyle.customFont(name: .f14PrimaryMedium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontStyle.customFont(name: .f10PrimaryRegular)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var favoriteButton: FavoriteButton = {
        let element = FavoriteButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return element
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        nil
    }
    
    public func buildViewHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(favoriteButton)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favoriteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(rgb: 0xA0A4A8).cgColor
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
    
    public func setup(with product: ProductResponse, isFavorite: Bool) {
        priceLabel.text = product.price
        nameLabel.text = product.name
        favoriteButton.productId = product.id ?? ""
        favoriteButton.isFavorite = isFavorite
        
        guard let url = product.image else { return }
        productImageView.addImageFromURL(urlString: url)
    }
    
    @objc func didTapFavorite() {
        favoriteButton.toggleState()
        delegate?.didTapFavorite(id: favoriteButton.productId,
                                 isFavorite: favoriteButton.isFavorite)
    }
}
