//
//  ProductDetailViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 31/10/22.
//

import UIKit

class ProductDetailViewController: DefaultViewController {
    
    private let productDetailView = ProductDetailView()
    private let networking = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = productDetailView
    }
    
    func callService() {
        networking.execute(endpoint: ProductsApi.get(id: "1")) { [weak self] (response: Result<ProductResponse, NetworkResponse>) in
            
        }
    }
}
