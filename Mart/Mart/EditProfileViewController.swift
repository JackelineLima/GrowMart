//
//  EditProfileViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol EditProfileDisplayable: AnyObject {
    func displaySomething()
}

final class EditProfileViewController: UIViewController {
    
    private lazy var editProfileView = EditProfileView()
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

extension EditProfileViewController: EditProfileDisplayable {
    func displaySomething() { }
}
