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
    private let networkManager = NetworkManager()
    
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
    
    private func authUser(login: String, password: String) {
        networkManager.execute(endpoint: AuthApi.auth(login: login, password: password)) { [weak self] (response: Result<AuthResponse?, NetworkResponse>) in
            
            switch response {
            case let .success(data):
                guard let userData = data else {
                    // Apresentar estado de erro
                    return
                }
                
                self?.persistInfo(user: userData)
                self?.showHomeScreen()
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
    
    private func showHomeScreen() {
        DispatchQueue.main.async {
            self.coordinator.navigateToPreferences()
        }
    }
    
    private func persistInfo(user: AuthResponse) {
        persistOnUserDefaults(user: user)
    }
    
    private func persistOnUserDefaults(user: AuthResponse) {
        let defaults = UserDefaults.standard
        
        defaults.set(user.id, forKey: "UserID")
        defaults.set(user.name, forKey: "UserName")
        defaults.set(user.email, forKey: "UserEmail")
        defaults.set(user.phone, forKey: "UserPhone")
        
        
        //guarda o objeto inteiro
        if let encoded = try? JSONEncoder().encode(user) {
            defaults.set(encoded, forKey: "User")
        }
        
        print("Name saved on UserDefaults: \(defaults.string(forKey: "UserName") ?? "NOT SAVED")")
        
        if let data = defaults.object(forKey: "User") as? Data,
           let user = try? JSONDecoder().decode(AuthResponse.self, from: data) {
            print("User saved on UserDefaults: \(user)")
        } else {
            print("User saved on UserDefaults: NOT SAVED")
        }
    }
    
//    private func persistOnKeyChain(user: AuthResponse) {
//           let keychain = KeychainWrapper.standard
//
//           if let id = user.id { keychain.set(id, forKey: "UserID") }
//           if let name = user.name { keychain.set(name, forKey: "UserName") }
//           if let email = user.email { keychain.set(email, forKey: "UserEmail") }
//           if let phone = user.phone { keychain.set(phone, forKey: "UserPhone") }
//           if let encoded = try? JSONEncoder().encode(user) {
//               keychain.set(encoded, forKey: "User")
//           }
//
//           print("Name saved on Keychain: \(keychain.string(forKey: "UserName") ?? "NOT SAVED")")
//
//           if let data = keychain.data(forKey: "User"),
//              let user = try? JSONDecoder().decode(AuthResponse.self, from: data) {
//               print("User saved on Keychain: \(user)")
//           } else {
//               print("User saved on Keychain: NOT SAVED")
//           }
//       }
}

extension LoginViewController: LoginViewDelegate {
    
    func didTap(login: String, password: String) {
        authUser(login: login, password: password)
    }
    
    func continueButtonFacebook() {
        coordinator.navigateToPreferences()
        print("******* continue facebook ******")
    }
    
    func continueButtonGoogle() {
        coordinator.navigateToPreferences()
        print("******* continue google ******")
    }
}
