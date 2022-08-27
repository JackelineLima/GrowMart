//
//  UIButtonPreferences.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import UIKit

enum UIButtonLayoutConfiguration {
    case right
    case left
}

class UIButtonPreferences: UIControl {
    
    private var layout: UIButtonLayoutConfiguration = .right
    private var buttonAction: (()-> Void)?
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    public convenience init(_ layout: UIButtonLayoutConfiguration = .right, nameLabel: String = "", imageName: String? = nil) {
        self.init()
    
        setupLayout(layout, nameLabel: nameLabel, imageName: imageName)
    }
    
    public func setupLayout(_ layout: UIButtonLayoutConfiguration = .right, nameLabel: String = "", imageName: String? = nil) {
        addSubview(categoryLabel)
        backgroundColor = .init(rgb: 0xF5F0E1)
        self.layout = layout
        layer.cornerRadius = 35
        categoryLabel.text = nameLabel
        categoryLabel.textAlignment = .left
        categoryLabel.font = UIFontStyle.customFont(name: .f25PrimaryExtraBold)
        categoryLabel.textColor = .init(rgb: 0xFF6E40)
        
        if let imageName = imageName {
            addSubview(categoryImage)
            categoryImage.image = UIImage(named: imageName)
        }
        
        setupConstraints()
        setupConfigButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
            categoryImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupConfigButton() {
        switch layout {
        case .right:
            setupConfigButtonRight()
        case .left:
            setupConfigButtonLeft()
        }
    }
    
    private func setupConfigButtonLeft() {
        NSLayoutConstraint.activate([
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            categoryImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 8)
        ])
    }
    
    private func setupConfigButtonRight() {
        NSLayoutConstraint.activate([
            categoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            categoryImage.leftAnchor.constraint(equalTo: leftAnchor, constant: -8)
        ])
    }
    
    public func setAction(_ action: (() -> Void)?) {
        buttonAction = action
        self.addTarget(self, action: #selector(onTap(sender:)), for: .touchUpInside)
    }
    
    @objc private func onTap(sender: UIButton) {
        buttonAction?()
    }
}
