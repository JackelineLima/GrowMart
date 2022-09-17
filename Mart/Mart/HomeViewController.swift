//
//  HomeViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import UIKit

final class HomeViewController: DefaultViewController {
    
//    private lazy var homeView = HomeView(categoryIndex: viewModel.categoryIndex)
    private lazy var homeView = HomeView2(categoryIndex: viewModel.categoryIndex)
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
        setupRightButtonNavigation(action: nil)
        viewModel.loadCategory()
    }
}

extension HomeViewController: HomeViewDelegate, HomeView2Delegate {
    
    func numberOfRows() -> Int {
        viewModel.products.count
    }
    
    func getProducts() -> [Product] {
        viewModel.products
    }
    
    func didTapSegmented(index: Int) {
        viewModel.categoryIndex = index
        viewModel.loadCategory()
        homeView.reloadCollection()
    }
    
    
    func didTapCell() {
        print("abrir celula")
    }
}
