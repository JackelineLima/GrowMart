//
//  UIPickerView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit
 
class PickerView: UIPickerView {
    private let data: [String]
    private let textField: UITextField
 
    init(data: [String], textField: UITextField) {
        self.data = data
        self.textField = textField
        
        super.init(frame: .zero)
 
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.main.async {
            self.textField.isEnabled = !data.isEmpty
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        nil
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data[row]
    }
}
