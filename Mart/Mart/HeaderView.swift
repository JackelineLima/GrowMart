//
//  HeaderView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/09/22.
//

import UIKit

class HeaderView: UIView {
    
    var didTapIcon: (()-> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontStyle.customFont(name: .f22PrimaryExtraBold)
        label.textColor = .black
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    init(textLabel: String, imageStrig: String, cornerRadiusValue: Double = 0) {
        super.init(frame: .zero)
        titleLabel.text = textLabel
        iconImage.image = UIImage(named: imageStrig)
        iconImage.layer.cornerRadius = cornerRadiusValue
        iconImage.isUserInteractionEnabled = true
        setupView()
    }
    
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func buildViewHierarchy() {
        addSubViews([titleLabel, iconImage])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        iconImage.addGestureRecognizer(gesture)
    }
    
    @objc private func didTap() {
        didTapIcon?()
    }
    
    func updateImageView(image: UIImage) {
        iconImage.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
