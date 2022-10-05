//
//  CheckoutViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import Foundation

protocol CheckoutViewModelProtocol {
    var product: [Product] { get }
    var reloadTableView: (() -> Void)? { get set }
    func remove(product: Product)
    func backButton()
}

class CheckoutViewModel: CheckoutViewModelProtocol {
    
    var reloadTableView: (() -> Void)?
    
    let coordinator: CheckoutCoordinatorProtocol
    
    var product: [Product] = [Product(name: "título produto 1", price: "R$ 0,00"),
                              Product(name: "título produto 2", price: "R$ 0,00"),
                              Product(name: "título produto 3", price: "R$ 0,00")]
    
    init(coordinator: CheckoutCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func remove(product: Product) {
        self.product.enumerated().forEach { index, element in
            if element.name == product.name {
                self.product.remove(at: index)
            }
        }
        reloadTableView?()
    }
    
    func backButton() {
        coordinator.popViewController()
    }
}
