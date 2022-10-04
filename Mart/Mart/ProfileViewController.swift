//
//  ProfileViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol ProfileDisplayable: AnyObject {
    func displaySomething()
}

class ProfileViewController: DefaultViewController {
    
    private lazy var profileView: ProfileView = {
        let element = ProfileView(profile: profile,
                                  memberSince: "membro desde: dd/mm/yy")
        return element
    }()
    
    
    private var profile: Profile = .init(name: "Michelli Cristina",
                                         address: "Rua das Flores",
                                         number: "099",
                                         complement: "00000-000",
                                         email: "teste@teste.com",
                                         cellphone: "(00) 00000-0000",
                                         canShareWhatsapp: true)
    
    private let viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        profileView.delegate = self
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: ProfileViewDelegate {
    
    func didTapActionButton() {
        viewModel.navigateToEditPerfil(delegate: self)
    }
    
    
    func didTapProfileImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        profileView.updateImageView(image: image)
        dismiss(animated: true)
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    
    func updateProfile(data: Profile) {
        self.profile = data
        profileView.reloadData(profile: profile)
    }
}
    
