//
//  CheckoutTableViewCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/09/22.
//

import UIKit

protocol CheckoutTableViewCellDelegate: AnyObject {
    func remove(product: Product)
}

class CheckoutTableViewCell: UITableViewCell, ViewCodable {

    static let identifier = "CheckoutTableViewCell"
    weak var delegate: CheckoutTableViewCellDelegate?
    var product: Product?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(rgb: 0xFFC13B).cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(rgb: 0xFFC13B).cgColor
        view.image = UIImage(named: "clothes_checkout")
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontStyle.customFont(name: .f16PrimaryMedium)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "título produto 1"
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontStyle.customFont(name: .f16PrimaryMedium)
        label.textColor = UIColor(rgb: 0xA0A4A8)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "R$ 0,00"
        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .setButtonConfiguration(backgroundColor: .white, title: "remover", icon: nil, font: .f14PrimaryRegular, textColor: .init(rgb: 0x4267B2))
        button.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(removeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            priceLabel.heightAnchor.constraint(equalToConstant: 40),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: 16),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            removeButton.widthAnchor.constraint(equalToConstant: 80),
            removeButton.heightAnchor.constraint(equalToConstant: 40),
            removeButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            removeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupCell(with product: Product) {
        self.product = product
        nameLabel.text = product.name
        priceLabel.text = product.price
    }
    
    @objc func didTapRemoveButton() {
        delegate?.remove(product: product!)
    }
}
