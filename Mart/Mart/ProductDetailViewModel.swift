//
//  ProductDetailViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/11/22.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    func backButton()
    func callService()
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    weak var delegate: ProductDetailViewControllerProtocol?
    private let networkManager = NetworkManager()
    let coordinator: ProductDetailCoodinatorProtocol
    
    init(coordinator: ProductDetailCoodinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func callService() {
        networkManager.execute(endpoint: ProductsApi.get(id: "1")) { [weak self] (response: Result<ProductResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                safeSelf.delegate?.set(product: data)
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }

    func backButton() {
        coordinator.popViewController()
    }
}
