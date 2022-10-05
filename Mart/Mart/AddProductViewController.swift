//
//  AddProductViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

protocol AddProductDisplayable: AnyObject {
    func displaySomething()
}

class AddProductViewController: DefaultViewController {
    
    private lazy var contentView = AddProductView()
    private let viewModel: AddProductViewModelProtocol

    init(viewModel: AddProductViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        contentView.delegate = self
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddProductViewController: AddProductViewDelegate {
    
    func addProduct(_ product: Product) {
        print("adicionar produtos")
    }
}
