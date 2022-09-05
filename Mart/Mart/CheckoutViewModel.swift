//
//  CheckoutViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import Foundation

protocol CheckoutViewModelProtocol {
    var product: [Product] { get set }
    func remove(product: Product)
}

class CheckoutViewModel: CheckoutViewModelProtocol {
    
    var product: [Product] = [Product(name: "título produto 1", price: "R$ 0,00"),
                              Product(name: "título produto 2", price: "R$ 0,00"),
                              Product(name: "título produto 3", price: "R$ 0,00")]
    
    let coordinator: CheckoutCoordinatorProtocol
    
    init(coordinator: CheckoutCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func remove(product: Product) {
        
    }
}
