//
//  EditProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

final class EditProfileView: UIView, ViewCodable {
    
    private lazy var titleProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "editar perfil"
        label.font = UIFontStyle.customFont(name: .f22PrimaryExtraBold)
        label.textColor = .black
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "edit-profile")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubViews([titleProfileLabel, profileImage])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleProfileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleProfileLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            profileImage.centerYAnchor.constraint(equalTo: titleProfileLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
