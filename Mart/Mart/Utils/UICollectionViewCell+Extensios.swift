//
//  UICollectionView+Extensios.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import UIKit
import Foundation

extension UICollectionViewCell {
    
    public static var reuseIdentifier: String {
        String(describing: self)
    }
    
    public class func createCell<T: UICollectionViewCell>(_
                                                          collectionView: UICollectionView,
                                                          cellForItemAt indexPath: IndexPath) -> T? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
