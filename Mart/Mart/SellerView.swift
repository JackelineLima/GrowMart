//
//  SellerView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 31/10/22.
//

import UIKit

class SellerView: UIStackView {
    
    private var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    private var memberSince: String = "" {
        didSet {
            memberSinceLabel.text = memberSince
        }
    }
    
    private var sales: String = "" {
        didSet {
            salesLabel.text = sales
        }
    }

    private var labelValues: [LabelValueView] = []

    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f18PrimarySemiBold)
        element.textColor = .black
        element.numberOfLines = 1
        return element
    }()
    
    private lazy var memberSinceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f12PrimaryMedium)
        element.textColor = .init(rgb: 0xA0A4A8)
        element.numberOfLines = 1
        return element
    }()
    
    private lazy var salesLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f14PrimaryRegular)
        element.textColor = .black
        element.numberOfLines = 1
        return element
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func updateData(name: String,
                    memberSince: String,
                    sales: String) {
        self.name = name
        self.memberSince = memberSince
        self.sales = sales
    }
}

extension SellerView: ViewCodable {
    
    func buildViewHierarchy() {
        addArrangedSubview(nameLabel)
        addArrangedSubview(memberSinceLabel)
        addArrangedSubview(salesLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            memberSinceLabel.heightAnchor.constraint(equalToConstant: 40),
            salesLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        axis = .vertical
        distribution = .fill
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0x1E3D59).cgColor
        
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
    }
}
