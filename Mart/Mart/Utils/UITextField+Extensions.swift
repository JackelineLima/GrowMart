//
//  UITextField+Extensions.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = PickerView(data: data, textField: self)
    }
}
