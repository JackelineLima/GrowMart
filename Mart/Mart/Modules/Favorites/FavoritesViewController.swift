//
//  FavoritesViewController.swift
//  Mart
//
//  Created by Jackeline Pires de Lima on 17/11/22.
//

import UIKit

class FavoritesViewController: DefaultViewController {
    // MARK: - Private Properties
    private lazy var favoritesView: FavoritesView = {
        let element = FavoritesView()
        element.delegate = self
        return element
    }()
    
    private var favorites = [Favorite]() {
        didSet {
            favoritesView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        loadFavorites()
    }
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    // MARK: - Private Methods
    
    private func loadFavorites() {
//        favorites = DataManager.shared.loadFavorites()
    }
}

// MARK: - CatalogViewDelegate
extension FavoritesViewController: FavoritesViewDelegate {
    func numberOfItems() -> Int {
        favorites.count
    }
    
    func getFavorite(at index: Int) -> Favorite? {
        guard index < favorites.count else {
            return nil
        }

        return favorites[index]
    }
        
    func didTapFavorite(at index: Int) {
//        navigationController?.pushViewController(ProductDetailViewController(), animated: true)
    }
    
    func didTapRemove(id: String) {
//        DataManager.shared.removeFavorite(id: id)
        loadFavorites()
        favoritesView.reloadData()
        
        NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"), object: nil)
    }
}
