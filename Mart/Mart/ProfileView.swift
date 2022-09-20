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
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(textLabel: "meu perfil", imageStrig: "profile", cornerRadiusValue: 25)
        view.translatesAutoresizingMaskIntoConstraints = false
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
        addSubViews([headerView, infoView, profileButton])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            infoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
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
        
        headerView.didTapIcon  = {
            self.delegate?.didTapProfileImage()
        }
        
        profileButton.onTapAction = {
            self.delegate?.didTapActionButton()
        }
    }
    
    func updateImageView(image: UIImage) {
        headerView.updateImageView(image: image)
    }
}
