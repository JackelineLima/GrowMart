//
//  HomeView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapCell()
    func didTapSegmented(index: Int)
    func numberOfRows() -> Int
    func getProducts() -> [Product]
}

final class HomeView: UIView, ViewCodable {
    
    weak var delegate: HomeViewDelegate?
    private let categoryIndex: Int
    
    private lazy var search: SearchBar = {
        let search = SearchBar()
        search.placeholder = "buscar"
        search.borderStyle = .roundedRect
        search.layer.borderColor = UIColor.black.cgColor
        search.layer.cornerRadius = 5
        search.rightViewMode = .always
        search.font = UIFontStyle.customFont(name: .f16PrimaryRegular)
        search.rightView = UIImageView(image: UIImage(named: "search"))
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
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
        let segmented = SegmentedBar(collections: ["roupas", "acessórios", "outros"], index: categoryIndex)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.delegate = self
        return segmented
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 32, left: 0, bottom: 16, right: 0)
        let spacesBetweenItens: CGFloat = 80
        layout.itemSize = .init(width: (UIScreen.main.bounds.width - spacesBetweenItens) / 2, height: 230)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubViews([search, bannerView, segmentedControl, collectionView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            search.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            search.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            search.heightAnchor.constraint(equalToConstant: 45),
            
            bannerView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 32),
            bannerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            bannerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            bannerView.heightAnchor.constraint(equalToConstant: 150),
            
            segmentedControl.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfRows() ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell, let products = delegate?.getProducts() else { return UICollectionViewCell() }
        
        cell.setup(with: products[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension HomeView: SegmentedBarDelegate {
    
    func didTapSegmented(index: Int) {
        delegate?.didTapSegmented(index: index)
    }
}
