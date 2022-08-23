//
//  ViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let coordinator: LoginCoordinatorProtocol

    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        loginView.delegate = self
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate {
    func continueButtonFacebook() {
        coordinator.navigateToPreferences()
        print("******* continue facebook ******")
    }
    func continueButtonGoogle() {
        print("******* continue google ******")
    }
}
