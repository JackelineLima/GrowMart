//
//  CheckoutViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import UIKit

class CheckoutViewController: UIViewController {
    
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
    }
}

extension CheckoutViewController: CheckoutViewDelegate {
    
    func remove(product: Product) {
        print("Removeu produto: \(product.name)")
//        viewModel.product.removeAll { cell in
//            return cell.name == product.name
//        }
//
//        checkoutView.reloadTableView()
    }
}


