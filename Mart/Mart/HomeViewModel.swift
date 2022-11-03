//
//  HomeViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    func callService()
    func navigatoToCar()
    var products: [ProductResponse] { get }
    var categoryIndex: Int { get set }
    var delegate: HomeViewControllerDelegate? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var network = NetworkManager()
    internal var products: [ProductResponse] = []
    let coordinator: HomeCoordinator
    var categoryIndex: Int
    weak var delegate: HomeViewControllerDelegate?
    
    init(coordinator: HomeCoordinator,_ categoryIndex: Int) {
        self.coordinator = coordinator
        self.categoryIndex = categoryIndex
    }
    
    func callService() {
        network.execute(endpoint: ProductsApi.list(page: 20)) { [weak self] (response: Result<ProductsResponse, NetworkResponse>) in
            switch response {
            case .success(let data):
                guard let products = data.entries else {
                    return
                }
                self?.products.append(contentsOf: products)
                self?.delegate?.reload()
            case .failure:
                print("error")
            }
        }
    }
    
    func navigatoToCar() {
        coordinator.navigateToCar()
    }
}
