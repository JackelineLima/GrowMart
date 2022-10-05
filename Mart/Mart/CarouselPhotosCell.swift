//
//  CarouselPhotosCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import UIKit

protocol CarouselPhotosCellDelegate: AnyObject {
    func didTapAddPhotoButton()
    func didTapPhoto(at index: Int)
}

class CarouselPhotosCell: UITableViewCell {
    
    weak var delegate: CarouselPhotosCellDelegate?
    
    private var photos: [Photo] = [] {
        didSet {
            addButton.isHidden = !photos.isEmpty
            collectionView.reloadData()
        }
    }
    
    private lazy var addButton: UIControl = {
        let element = UIControl()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.layer.cornerRadius = 5
        element.layer.borderColor = UIColor(rgb: 0xFF6E40).cgColor
        element.layer.borderWidth = 1
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        element.addTarget(self, action: #selector(didTapAddPhotoButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var addPhotoLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f18PrimaryMedium)
        element.textColor = UIColor(rgb: 0xFF6E40)
        element.numberOfLines = 1
        element.textAlignment = .center
        element.text = "adicionar foto"
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var addPhotoIcon: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = .init(named: "add-photo")
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let spacesBetweenItens: CGFloat = 80
        viewLayout.itemSize = .init(width: (UIScreen.main.bounds.width - spacesBetweenItens) / 2, height: 150)
        viewLayout.minimumInteritemSpacing = 16
        viewLayout.scrollDirection = .horizontal
        
        let element = UICollectionView(frame: .zero,
                                       collectionViewLayout: viewLayout)
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.delegate = self
        element.dataSource = self
        return element
    }()
    
    @objc
    private func didTapAddPhotoButton(_ sender: Any) {
        delegate?.didTapAddPhotoButton()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension CarouselPhotosCell: ViewCodable {
    
    public func buildViewHierarchy() {
        contentView.addSubview(collectionView)
        contentView.addSubview(addButton)
        addButton.addSubview(addPhotoIcon)
        addButton.addSubview(addPhotoLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 150),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            addPhotoIcon.widthAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.heightAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.topAnchor.constraint(equalTo: addButton.topAnchor, constant: 48),
            addPhotoIcon.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            
            addPhotoLabel.topAnchor.constraint(equalTo: addPhotoIcon.bottomAnchor, constant: 4),
            addPhotoLabel.leadingAnchor.constraint(equalTo: addButton.leadingAnchor),
            addPhotoLabel.trailingAnchor.constraint(equalTo: addButton.trailingAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoCell.reuseIdentifier)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
    }
    
    public func setPhotos(photos: [Photo]) {
        self.photos = photos
    }
    
    private func totalCells() -> Int {
        photos.count + 1
    }
    
}

extension CarouselPhotosCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalCells()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard totalCells() > indexPath.row else {
            return UICollectionViewCell()
        }
        
        //igual a 0 items
        if indexPath.row == totalCells() - 1, let cell: AddPhotoCell = .createCell(collectionView, cellForItemAt: indexPath) {
            return cell
        }

        if let cell: PhotoCell = .createCell(collectionView, cellForItemAt: indexPath) {
            cell.setup(with: photos[indexPath.row])
            return cell
        }

        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == totalCells() - 1 {
            delegate?.didTapAddPhotoButton()
        } else {
            delegate?.didTapPhoto(at: indexPath.row)
        }
    }
}
