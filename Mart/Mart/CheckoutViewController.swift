//
//  CheckoutViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import UIKit

class CheckoutViewController: DefaultViewController {
    
    private var viewModel: CheckoutViewModelProtocol
    private lazy var checkoutView = CheckoutView(viewModel: viewModel)
   
    init(viewModel: CheckoutViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        checkoutView.delegate = self
        view = checkoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeftButtonNavigation(action: #selector(backButton))
    }
    
    func reloadTableView() {
        checkoutView.reloadTableView()
    }
    
    @objc func backButton() {
        viewModel.backButton()
    }
}

extension CheckoutViewController: CheckoutViewDelegate {
    
    func didTapCheckout() {
        print("button checkout")
    }
    
    func remove(product: Product) {
        viewModel.remove(product: product)
    }
}


