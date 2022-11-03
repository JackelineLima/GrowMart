//
//  ProductDetailView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 31/10/22.
//

import UIKit

protocol ProductDetailViewDelegate: AnyObject {
    func didTapAddToCart()
    func didTapShare()
}

final class ProductDetailView: UIView, ViewCodable {
    
    weak var delegate: ProductDetailViewDelegate?
    
    private lazy var scrollView: SimpleScrollView = {
        let element = SimpleScrollView(spacing: 32,
                                       margins: .init(top: 32, leading: 32, bottom: 32, trailing: 32))
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var productDetailStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 8
        element.distribution = .fill
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f18PrimarySemiBold)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var photoImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var priceStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 8
        element.distribution = .fill
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f18PrimarySemiBold)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var shareButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        element.setImage(UIImage(named: "share"), for: .normal)
        return element
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f18PrimaryMedium)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = "descrição"
        return element
    }()
    
    private lazy var descriptionValueLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f16PrimaryRegular)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var addToCartButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
        element.setTitleColor(.black, for: .normal)
        element.configuration = .setButtonConfiguration(
            backgroundColor: UIColor(rgb: 0xFFC13B),
            title: "adicionar a sacolinha",
            font: .f18PrimaryMedium,
            textColor: .black)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var detailsView: InfoGroupView = {
        let element = InfoGroupView(title: "detalhes", infos: [], footerMessage: nil)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var sellerView: SellerView = {
        let element = SellerView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    private func didTapAddToCart() {
        delegate?.didTapAddToCart()
    }
    
    @objc
    private func didTapShare() {
        delegate?.didTapShare()
    }
    
    func set(product: ProductResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.updateProductData(product: product)
            self?.updateDetailsView(product: product)
            self?.updateSellerView(product: product)
        }
    }

    private func updateProductData(product: ProductResponse) {
        nameLabel.text = product.name
        photoImageView.addImageFromURL(urlString: product.image ?? "")
        priceLabel.text = product.price
        descriptionValueLabel.text = product.description
    }
    
    private func updateDetailsView(product: ProductResponse) {
        detailsView.updateData(
            infos: [
                ("tamanho", product.size ?? ""),
                ("condição", product.condition ?? ""),
                ("marca", product.brand ?? "")
            ],
            footerMessage: "")
    }
    
    private func updateSellerView(product: ProductResponse) {
        sellerView.updateData(name: product.seller?.name ?? "",
                              memberSince: product.seller?.memberSince ?? "",
                              sales: "\(product.seller?.sales ?? 0) vendas")
    }
}

extension ProductDetailView {
    
    func buildViewHierarchy() {
        productDetailStackView.addArrangedSubview(nameLabel)
        productDetailStackView.addArrangedSubview(photoImageView)
        productDetailStackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(shareButton)
        productDetailStackView.addArrangedSubview(descriptionTitleLabel)
        productDetailStackView.addArrangedSubview(descriptionValueLabel)
        
        scrollView.addSubview(productDetailStackView)
        scrollView.addSubview(addToCartButton)
        scrollView.addSubview(detailsView)
        scrollView.addSubview(sellerView)
        
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupAdditionalConfiguration() {
        scrollView.addCustomSpace(spacing: 72, afterView: productDetailStackView)
    }
}
