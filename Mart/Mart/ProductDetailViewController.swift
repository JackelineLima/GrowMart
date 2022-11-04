//
//  ProductDetailViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 31/10/22.
//

import UIKit

protocol ProductDetailViewControllerProtocol: AnyObject {
    func set(product: ProductResponse)
}

class ProductDetailViewController: DefaultViewController {
    
    private let productDetailView = ProductDetailView()
    private let viewModel: ProductDetailViewModelProtocol
    
    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeftButtonNavigation(action: #selector(backButton))
        viewModel.callService()
    }
    
    override func loadView() {
        super.loadView()
        productDetailView.delegate = self
        view = productDetailView
    }
    
    @objc func backButton() {
        viewModel.backButton()
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    
    func didTapAddToCart() {
        print("didTapAddToCart")
    }
    
    func didTapShare() {
        let controller = UIActivityViewController(activityItems: [
            "Olha que produto incrível encontrei no Growmart!",
            URL(string: "https://www.amazon.com.br/gp/product/B00ELBQK1W/ref=ewc_pr_img_3?smid=A1ZZFT5FULY4LN&psc=1")!
        ], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        present(controller, animated: true, completion: nil)
    }
}

extension ProductDetailViewController: ProductDetailViewControllerProtocol {
    func set(product: ProductResponse) {
        productDetailView.set(product: product)
    }
}
