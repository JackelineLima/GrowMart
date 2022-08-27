//
//  PreferencesViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit

class PreferencesSellViewController: UIViewController {
    
    private let preferencesView = PreferencesSellView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = preferencesView
        
        preferencesView.buttonAction = { preference in
            print("******* preferencia \(preference) *******")
            self.navigateToPreferences(preference)
        }
    }
    
    private func navigateToPreferences(_ preference: TypePreferences) {
        switch preference {
        case .clothes:
            print("roupas")
        case .accessories:
            print("acessorios")
        case .others:
            print("outros")
        }
    }
}
