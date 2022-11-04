//
//  ProductDetailViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/11/22.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    func backButton()
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    let coordinator: ProductDetailCoodinatorProtocol
    
    init(coordinator: ProductDetailCoodinatorProtocol) {
        self.coordinator = coordinator
    }
    

    func backButton() {
        coordinator.popViewController()
    }
}
