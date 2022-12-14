//
//  FavoriteButton.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import UIKit

class FavoriteButton: UIButton {
    var productId = ""
    var isFavorite = false {
        didSet {
            let color: UIColor = isFavorite ? .init(rgb: 0xFFC13B) : .white
            setImage(.makeWith(systemImage: .starFill, color: color), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(.makeWith(systemImage: .starFill, color: .white), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleState() {
        isFavorite = !isFavorite
    }
}
