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

final class ProfileViewController: DefaultViewController {
    
    private lazy var profileView = ProfileView()
    private let viewModel: ProfileViewModelProtocol

    init(viewModel: ProfileViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: ProfileDisplayable {
    func displaySomething() { }
}
