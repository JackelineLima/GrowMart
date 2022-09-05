//
//  PreferencesViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit

class PreferencesSellViewController: UIViewController {
    
    private var coordinator: PreferencesSellCoordinator
    private let preferencesView = PreferencesSellView()
    
    init(coordinator: PreferencesSellCoordinator) {
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
        view = preferencesView
        
        preferencesView.buttonAction = { preference in
            self.navigateToPreferences(preference)
        }
    }
    
    private func navigateToPreferences(_ preference: TypePreferences) {
        switch preference {
        case .clothes:
            print("roupas")
            let coordinator = CheckoutCoordinator(navigationController: navigationController!)
            coordinator.start()
        case .accessories:
            print("acessorios")
            coordinator.navigateToHome()
        case .others:
            print("outros")
            coordinator.navigateToHome()
        }
    }
}
