//
//  PreferencesViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit

protocol PreferencesViewControllerDelegate: AnyObject {
    func renderButtons(categories: [CategoryResponse]?)
}

class PreferencesViewController: UIViewController {
    
    private var viewModel: PreferencesViewModelProtocol
    private var preferencesView = PreferencesView()
    
    init(viewModel: PreferencesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callService()
        viewModel.delegate(self)
    }
    
    override func loadView() {
        super.loadView()
        preferencesView.delegate = self
        view = preferencesView
    }
    
    private func navigateToPreferences(_ preference: TypePreferences) {
        switch preference {
        case .clothes:
            //            let coordinator = AddProductCoordinator(navigationController: navigationController!)
            //            coordinator.start()
            viewModel.navigateToHome(index: preference.rawValue)
//            let controller = ProductDetailViewController(viewModel: )
//            navigationController?.pushViewController(controller, animated: true)
//            present(controller, animated: true)
        case .accessories:
            viewModel.navigateToHome(index: preference.rawValue)
        case .others:
            viewModel.navigateToHome(index: preference.rawValue)
        }
    }
}

extension PreferencesViewController: PreferencesViewControllerDelegate {
    
    func renderButtons(categories: [CategoryResponse]?) {
        if let categories = categories {
            DispatchQueue.main.async {
                self.preferencesView.renderButtons(categories: categories)
            }
        }
    }
}

extension PreferencesViewController: PreferencesViewDelegate {
    
    func buttonAction(preferences: TypePreferences) {
        viewModel.navigateToHome(index: preferences.rawValue)
    }
}
