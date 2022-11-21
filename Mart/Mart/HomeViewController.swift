//
//  HomeViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func reload()
}

class HomeViewController: DefaultViewController {
    
    private lazy var homeView = HomeView(categoryIndex: viewModel.categoryIndex)
    private var viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        homeView.delegate = self
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenLineView()
        setupRightButtonNavigation(action: #selector(didTapButtonNavigation))
        viewModel.delegate = self
        viewModel.callService()
    }
    
    @objc private func didTapButtonNavigation() {
        viewModel.navigatoToCar()
    }
}

extension HomeViewController: HomeViewDelegate {
    
    func didTapFilterButton() {
        
    }
    
    func isFavorite(id: String) -> Bool {
        
        return false
    }
    
    func didTapFavorite(id: String, isFavorite: Bool) {
        
    }
    
    
    func didTapProduct(at index: Int) {
        viewModel.navigatoToProductDetail()
    }
    
    func numberOfRows() -> Int {
        viewModel.products.count
    }
    
    func getProducts() -> [ProductResponse] {
        viewModel.products
    }
    
    func didTapSegmented(index: Int) {
        viewModel.categoryIndex = index
        viewModel.callService()
        homeView.reloadCollection()
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func reload() {
        homeView.reloadCollection()
    }
}
