//
//  HomeCollectionView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 13/09/22.
//

import UIKit

class HomeCollectionView: UICollectionView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
