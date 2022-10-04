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
    private var profile: Profile
    private let memberSince: String?
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(textLabel: "meu perfil", imageStrig: "profile", cornerRadiusValue: 25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: InfoGroupView = {
        let view = InfoGroupView(title: "DADOS PESSOAIS",
                                 infos: getProfileInfo(),
                                 footerMessage: "membro desde: dd/mm/yy")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileButton: GrowButton = {
        let button = GrowButton(style: .buttonBordered, title: "editar dados", imageString: "pencil")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(profile: Profile,
         memberSince: String? = nil) {
        self.profile = profile
        self.memberSince = memberSince
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        nil
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
    
    func reloadData(profile: Profile) {
        self.profile = profile
        infoView.updateData(infos: getProfileInfo(),
                                footerMessage: memberSince)
    }
    
    private func getProfileInfo() -> [(String, String)] {
           return [
               ("nome", profile.name ?? ""),
               ("endereço", profile.address ?? ""),
               ("número", profile.number ?? ""),
               ("complemento", profile.complement ?? ""),
               ("email", profile.email ?? ""),
               ("celular", profile.cellphone ?? "")
           ]
       }
}
