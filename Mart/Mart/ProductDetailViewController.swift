//
//  ProductDetailViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 31/10/22.
//

import UIKit

class ProductDetailViewController: DefaultViewController {
    
    private let productDetailView = ProductDetailView()
    private let networkManager = NetworkManager()
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
        callService()
    }
    
    override func loadView() {
        super.loadView()
        productDetailView.delegate = self
        view = productDetailView
    }
    
    private func callService() {
        networkManager.execute(endpoint: ProductsApi.get(id: "1")) { [weak self] (response: Result<ProductResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                safeSelf.productDetailView.set(product: data)
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
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
