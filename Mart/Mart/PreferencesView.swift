//
//  Preferences.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import Foundation
import UIKit

final class PreferencesView: UIView {
    
    private lazy var preferencesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = <#UIStackView.Distribution#>
        stackView.spacing = 32
        return stackView
    }()
    
    private let clothesButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        button.setupLayout(.left,nameLabel: "Roupas", imageName: "clothes")
        return button
    }()
    
    private let accessoriesButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        button.setupLayout(nameLabel: "Acessórios", imageName: "accessories")
        return button
    }()
    
    private let othersButton: UIButtonPreferences = {
        let button = UIButtonPreferences()
        button.setupLayout(.left,nameLabel: "Outros", imageName: "others")
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PreferencesView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(preferencesStackView)
        preferencesStackView.addArrangedSubview(clothesButton)
        preferencesStackView.addArrangedSubview(accessoriesButton)
        preferencesStackView.addArrangedSubview(othersButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            preferencesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56),
            preferencesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            preferencesStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            preferencesStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
