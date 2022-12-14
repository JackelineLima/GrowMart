//
//  Preferences.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import Foundation
import UIKit

enum TypePreferences: Int {
    case clothes = 0
    case accessories
    case others
}

protocol PreferencesViewDelegate: AnyObject {
    func buttonAction(preferences: TypePreferences)
}

final class PreferencesView: UIView {

    weak var delegate: PreferencesViewDelegate?
    private var categories: [CategoryResponse] = []
    
    private lazy var preferencesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var preferecensLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O que você quer comprar/vender?"
        label.textAlignment = .center
        label.textColor = .init(rgb: 0x1E3D59)
        label.font = UIFontStyle.customFont(name: .f30PrimaryExtraBold)
        label.numberOfLines = 0
        return label
    }()
    
    private let clothesButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        return button
    }()
    
    private let accessoriesButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        return button
    }()
    
    private let othersButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupButtonAction() {
        othersButton.setAction {
            self.delegate?.buttonAction(preferences: .others)
        }
        
        accessoriesButton.setAction {
            self.delegate?.buttonAction(preferences: .accessories)
        }
        
        clothesButton.setAction {
            self.delegate?.buttonAction(preferences: .clothes)
        }
    }
    
    func renderButtons(categories: [CategoryResponse]) {
        self.categories = categories
        clothesButton.setupLayout(.left, nameLabel: self.categories[0].name ?? "", imageName: "clothes")
        accessoriesButton.setupLayout(nameLabel: self.categories[1].name ?? "", imageName: "accessories")
        othersButton.setupLayout(.left, nameLabel: self.categories[2].name ?? "", imageName: "others")
    }
}

extension PreferencesView: ViewCodable {
    
    func buildViewHierarchy() {
        addSubViews([preferecensLabel, preferencesStackView])
        preferencesStackView.addArrangedSubview(clothesButton)
        preferencesStackView.addArrangedSubview(accessoriesButton)
        preferencesStackView.addArrangedSubview(othersButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            preferecensLabel.bottomAnchor.constraint(equalTo: preferencesStackView.topAnchor, constant: -72),
            preferecensLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56),
            preferecensLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            
            preferencesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56),
            preferencesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            preferencesStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            preferencesStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
