//
//  SearchBar.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 10/09/22.
//

import UIKit

class SearchBar: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 16
        return rect
    }
}
