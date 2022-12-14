//
//  PhotoCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import UIKit

public class PhotoCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        element.backgroundColor = .init(rgb: 0xf3f6f4)
        return element
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        nil
    }
    

    func setup(with photo: Photo) {
        
        if let image = photo.imageToUpload {
            imageView.image = image
        } else {
            imageView.addImageFromURL(urlString: photo.imageUrl ?? "")
        }
    }
}

extension PhotoCell: ViewCodable {
    
    public func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
