//
//  EditProfileViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func updateProfile(data: Profile)
}

final class EditProfileViewController: DefaultViewController {
    
    weak var delegate: EditProfileViewControllerDelegate?
    private lazy var editProfileView = EditProfileView(delegate: self, profile: .init(
        name: "Jackeline",
        address: "José Bonifácio"))
    private let viewModel: EditProfileViewModelProtocol

    init(viewModel: EditProfileViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EditProfileViewController: EditProfileViewDelegate {
    
    func updateProfile(data: Profile) {
        delegate?.updateProfile(data: data)
        viewModel.dismiss()
    }
}
