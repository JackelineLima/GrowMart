//
//  ProductDetailCoodinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/11/22.
//

import UIKit

protocol ProductDetailCoodinatorProtocol {
    func start()
    func popViewController()
}

class ProductDetailCoodinator: ProductDetailCoodinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProductDetailViewModel(coordinator: self)
        let controller = ProductDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
