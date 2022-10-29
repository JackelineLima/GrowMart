//
//  PreferencesSellViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 29/10/22.
//

import Foundation

protocol PreferencesSellProtocol {
    func callService()
    func navigateToHome(index category: Int)
    func delegate(_ delegate: PreferencesSellViewControllerDelegate)
}

class PreferencesSellViewModel: PreferencesSellProtocol {
    
    weak var delegate: PreferencesSellViewControllerDelegate?
    private let coordinator: PreferencesSellCoordinatorProtocol
    private let networkManager: NetworkManager
    
    init(coordinator: PreferencesSellCoordinatorProtocol, networkManager: NetworkManager = NetworkManager()) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func delegate(_ delegate: PreferencesSellViewControllerDelegate) {
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
