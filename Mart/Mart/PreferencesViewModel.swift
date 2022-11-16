//
//  PreferencesSellViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 29/10/22.
//

import Foundation

protocol PreferencesViewModelProtocol {
    func callService()
    func navigateToHome(index category: Int)
    func delegate(_ delegate: PreferencesViewControllerDelegate)
}

class PreferencesViewModel: PreferencesViewModelProtocol {
    
    weak var delegate: PreferencesViewControllerDelegate?
    private let coordinator: PreferencesCoordinatorProtocol
    private let networkManager: NetworkManager
    
    init(coordinator: PreferencesCoordinatorProtocol, networkManager: NetworkManager = NetworkManager()) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func delegate(_ delegate: PreferencesViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func callService() {
        networkManager.execute(endpoint: CategoriesApi.list) { [weak self] (response: Result<CategoriesResponse, NetworkResponse>) in
            switch response {
            case .success(let data):
                guard let data = data.entries else {
                    self?.renderErrorState()
                    return
                }
                self?.delegate?.renderButtons(categories: data)
            case .failure:
                self?.renderErrorState()
            }
        }
    }
    
    private func renderErrorState() {
        print("renderErrorState")
    }
    
    func navigateToHome(index category: Int) {
        coordinator.navigateToHome(index: category)
    }
}
