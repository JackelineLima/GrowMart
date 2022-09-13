//
//  HomeView2View.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 12/09/22.
//

import UIKit

protocol HomeView2Delegate: AnyObject {
    func didTapCell()
    func didTapSegmented(index: Int)
    func numberOfRows() -> Int
    func getProducts() -> [Product]
}

final class HomeView2: UIView, ViewCodable {
    
    weak var delegate: HomeView2Delegate?

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
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.autoresizingMask = .flexibleHeight
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
        let segmented = SegmentedBar(collections: ["roupas", "acessórios", "outros"], index: 0)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.delegate = self
        return segmented
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
    
    init() {
//        self.categoryIndex = categoryIndex
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
        contentView.addSubViews([bannerView, segmentedControl, collectionView])
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
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
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

            segmentedControl.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45),

            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
}

extension HomeView2: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension HomeView2: SegmentedBarDelegate {

    func didTapSegmented(index: Int) {
        delegate?.didTapSegmented(index: index)
    }
}

