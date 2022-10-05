//
//  AddProductViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import Foundation

protocol AddProductViewModelProtocol {
    
}

class AddProductViewModel: AddProductViewModelProtocol {
    
    private let coordinator: AddProductCoordinatorProtocol

    init(coordinator: AddProductCoordinatorProtocol) {
      self.coordinator = coordinator
    }
}
