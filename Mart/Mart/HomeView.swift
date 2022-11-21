//
//  HomeView2View.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 12/09/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapProduct(at index: Int)
    func didTapSegmented(index: Int)
    func numberOfRows() -> Int
    func getProducts() -> [ProductResponse]
    
    func didTapFilterButton()
    func isFavorite(id: String) -> Bool
    func didTapFavorite(id: String, isFavorite: Bool)
}

final class HomeView: UIView, ViewCodable {
    
    weak var delegate: HomeViewDelegate?
    private var categoryIndex: Int
    private let accessories: [String] = ["roupas", "acessórios", "outros"]
    
    private lazy var search: SearchBar = {
        let search = SearchBar()
        search.placeholder = "buscar"
        search.borderStyle = .roundedRect
        search.layer.borderColor = UIColor.black.cgColor
        search.layer.borderWidth = 1
        search.layer.cornerRadius = 5
        search.rightViewMode = .always
        search.font = UIFontStyle.customFont(name: .f16PrimaryRegular)
        search.rightView = UIImageView(image: UIImage(named: "search"))
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.autoresizingMask = .flexibleHeight
        scroll.delegate = self
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bannerView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "banner")
        return image
    }()
    
    private lazy var segmentedControl: SegmentedBar = {
        let segmented = SegmentedBar(collections: accessories, index: categoryIndex)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.delegate = self
        return segmented
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
//        button.configuration = .setButtonConfiguration(backgroundColor: .init(rgb: 0xFFC13B), title: "filtros", font: .f18PrimarySemiBold, textColor: .white)
        button.backgroundColor = .red
        return button
    }()
    
    private lazy var closeBannerButton: UIButton = {
        let element = UIButton(type: .custom)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCloseBannerButton), for: .touchUpInside)
        element.setImage(.makeWith(systemImage: .xmark, color: .white), for: .normal)
        return element
    }()
    
    lazy var collectionView: HomeCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 32, left: 0, bottom: 16, right: 0)
        let spacesBetweenItens: CGFloat = 80
        layout.itemSize = .init(width: (UIScreen.main.bounds.width - spacesBetweenItens) / 2, height: 230)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let collection = HomeCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(HomeCollectionCell.self, forCellWithReuseIdentifier: HomeCollectionCell.identifier)
        return collection
    }()
    
    init(categoryIndex: Int) {
        self.categoryIndex = categoryIndex
        super.init(frame: .zero)
        backgroundColor = .white
        collectionView.isScrollEnabled = false
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(search)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([bannerView, segmentedControl, collectionView, filterButton, closeBannerButton])
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            search.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            search.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            search.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: search.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32),
        ])
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
        
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 150),
            
            closeBannerButton.heightAnchor.constraint(equalToConstant: 40),
            closeBannerButton.widthAnchor.constraint(equalToConstant: 40),
            closeBannerButton.topAnchor.constraint(equalTo: bannerView.topAnchor),
            closeBannerButton.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            filterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc
    func didTapFilterButton() {
        delegate?.didTapFilterButton()
    }
    
    @objc
    func didTapCloseBannerButton() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.bannerView.alpha = 0.0
        }, completion: { _ in
            self.bannerView.removeFromSuperview()
            self.segmentedControl.topAnchor.constraint(equalTo: self.search.bottomAnchor,
                                                       constant: 32).isActive = true
        })
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfRows() ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell, let products = delegate?.getProducts() else { return UICollectionViewCell() }
        
        var isFavorite = false
        if let id = products[indexPath.row].id,
           let value = delegate?.isFavorite(id: id) {
            isFavorite = value
        }
        cell.delegate = self
        cell.setup(with: products[indexPath.row], isFavorite: isFavorite)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapProduct(at: indexPath.row)
    }
    
}

extension HomeView: SegmentedBarDelegate {
    
    func didTapSegmented(index: Int) {
        delegate?.didTapSegmented(index: index)
    }
}

extension HomeView: HomeViewCellDelegate {
    func didTapFavorite(id: String, isFavorite: Bool) {
        delegate?.didTapFavorite(id: id, isFavorite: isFavorite)
    }
}
