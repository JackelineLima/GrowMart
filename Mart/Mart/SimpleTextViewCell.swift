//
//  SimpleTextViewCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 06/10/22.
//

import UIKit

public protocol SimpleTextViewCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class SimpleTextViewCell: UITableViewCell {
    
    public weak var delegate: SimpleTextViewCellDelegate?
    public var propertyName: String?

    private var placeholder = String()
    
    private lazy var textview: UITextView = {
        let element = UITextView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderColor = UIColor(rgb: 0x25282B).cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        element.font = UIFontStyle.customFont(name: .f18PrimarySemiBold)
        element.textContainerInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        element.delegate = self
        return element
    }()

    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setData(placeholder: String, value: String?) {
        self.placeholder = placeholder
        
        if let value = value, !value.isEmpty, value != placeholder {
            textview.text = value
            textview.textColor = .black
        } else {
            textview.textColor = .lightGray
            textview.text = placeholder
        }
    }
}

extension SimpleTextViewCell: ViewCodable {
    
    public func buildViewHierarchy() {
        contentView.addSubview(textview)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            textview.heightAnchor.constraint(equalToConstant: 125),
            textview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            textview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            textview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

extension SimpleTextViewCell: UITextViewDelegate {
    public func textView(_ textView: UITextView,
                         shouldChangeTextIn range: NSRange,
                         replacementText text: String) -> Bool {
        guard let value = textView.text as NSString? else {
            return false
        }
        
        let newValue = value.replacingCharacters(in: range, with: text)
        
        if newValue == placeholder.dropLast() {
            textview.textColor = .black
            textview.text = ""
            return false
        }

        if !newValue.isEmpty, newValue != placeholder {
            textview.textColor = .black
        } else {
            textview.textColor = .lightGray
        }
        
        delegate?.didChangeValue(propertyName: propertyName,
                                 value: newValue)
        return true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textview.text = ""
    }
}
