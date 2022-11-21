//
//  TabBarViewController.swift
//  Mart
//
//  Created by Jackeline Pires de Lima on 17/11/22.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var coodinator: TabBarCoodinatorProtocol

    init(coodinator: TabBarCoodinatorProtocol) {
      self.coodinator = coodinator
      super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .lightGray
        navigationBar?.standardAppearance = navigationBarAppearance
        navigationBar?.compactAppearance = navigationBarAppearance
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.compactScrollEdgeAppearance = navigationBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x1E3D59)
        ], for: .selected)

        viewControllers = [
            coodinator.getTabHome(),
            coodinator.getTabCart(),
            coodinator.getTabFavorites(),
            coodinator.getTabProfile()
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {

    }
    
}

protocol TabBarCoodinatorProtocol {
    func start()
    func getTabHome() -> UINavigationController
    func getTabCart() -> UINavigationController
    func getTabFavorites() -> UINavigationController
    func getTabProfile() -> UINavigationController
}

class TabBarCoodinator: TabBarCoodinatorProtocol {
    
    private let navigationController: UINavigationController
    private let categoryIndex: Int
    
    init(navigationController: UINavigationController,_ categoryIndex: Int) {
        self.navigationController = navigationController
        self.categoryIndex = categoryIndex
    }
    
    func start() {
        let controller = TabBarViewController(coodinator: self)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func getTabHome() -> UINavigationController {
        let coodinator = HomeCoordinator(navigationController: navigationController, categoryIndex)
        let viewModel = HomeViewModel(coordinator: coodinator, categoryIndex)
        let tabHome = HomeViewController(viewModel: viewModel)
        let tabHomeBarItem = UITabBarItem(title: "Home",
                                          image: .makeWith(name: "tab-home",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-home",
                                                                   color: .init(rgb: 0x1E3D59)))
        tabHome.tabBarItem = tabHomeBarItem
        
        return UINavigationController(rootViewController: tabHome)
    }
    
    func getTabCart() -> UINavigationController {
        let coodinator = CheckoutCoordinator(navigationController: navigationController)
        let viewModel = CheckoutViewModel(coordinator: coodinator)
        let tabCart = CheckoutViewController(viewModel: viewModel)
        let tabCartBarItem = UITabBarItem(title: "Carrinho",
                                          image: .makeWith(name: "tab-cart",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-cart",
                                                                   color: .init(rgb: 0x1E3D59)))

        tabCart.tabBarItem = tabCartBarItem
        
        return UINavigationController(rootViewController: tabCart)
    }
    
    func getTabFavorites() -> UINavigationController {
        let tabFavorites = FavoritesViewController()
        let tabFavoritesBarItem = UITabBarItem(title: "Favoritos",
                                               image: .makeWith(systemImage: .starFill,
                                                                color: .init(rgb: 0xA0A4A8)),
                                               selectedImage: .makeWith(systemImage: .starFill,
                                                                        color: .init(rgb: 0x1E3D59)))

        tabFavorites.tabBarItem = tabFavoritesBarItem
        
        return UINavigationController(rootViewController: tabFavorites)
    }
    
    func getTabProfile() -> UINavigationController {
        let coodinator = ProfileCoordinator(navigationController: navigationController)
        let viewModel = ProfileViewModel(coordinator: coodinator)
        let tabProfile = ProfileViewController(viewModel: viewModel)
        let tabProfileBarItem = UITabBarItem(title: "Perfil",
                                          image: .makeWith(name: "tab-profile",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-profile",
                                                                   color: .init(rgb: 0x1E3D59)))

        tabProfile.tabBarItem = tabProfileBarItem
        
        return UINavigationController(rootViewController: tabProfile)
    }
}
