//
//  ProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapProfileImage()
    func didTapActionButton()
}

final class ProfileView: UIView, ViewCodable {
    
    weak var delegate: ProfileViewDelegate?
    
    private lazy var titleProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meu perfil"
        label.font = UIFontStyle.customFont(name: .f22PrimaryExtraBold)
        label.textColor = .black
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "profile")
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var infoView: InfoGroupView = {
        let view = InfoGroupView(title: "DADOS PESSOAIS",
                                 infos: [(leftValue: "nome", rightValue: "Jackeline Lima"),
                                         (leftValue: "endereço", rightValue: "Rua José Bonifácio"),
                                         (leftValue: "cep", rightValue: "89066-370"),
                                         (leftValue: "email", rightValue: "nomeemail@gmail.com")],
                                 footerMessage: "membro desde: dd/mm/yy")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileButton: GrowButton = {
        let button = GrowButton(style: .buttonBordered, title: "editar dados", imageString: "pencil")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubViews([titleProfileLabel, profileImage, infoView, profileButton])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleProfileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleProfileLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            profileImage.centerYAnchor.constraint(equalTo: titleProfileLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            infoView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 32),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            profileButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 32),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            profileButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileImage.addGestureRecognizer(gesture)
        
        profileButton.onTapAction = {
            self.delegate?.didTapActionButton()
        }
    }
    
    func updateImageView(image: UIImage) {
        profileImage.image = image
    }
    
    @objc private func didTapProfileImage() {
        delegate?.didTapProfileImage()
    }
}
