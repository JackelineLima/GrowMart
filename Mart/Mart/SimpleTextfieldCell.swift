//
//  SimpleTextfieldCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/09/22.
//

import UIKit

public protocol SimpleTextfieldCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class SimpleTextfieldCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: SimpleTextfieldCellDelegate?
    public var propertyName: String?

    // MARK: Private Properties
    private lazy var textField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .roundedRect
        element.tintColor = .black
        element.font = UIFontStyle.customFont(name: .f18PrimaryMedium)
        element.delegate = self
        return element
    }()
        
    // MARK: Inits
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
    public func setData(placeholder: String, value: String?) {
        textField.placeholder = placeholder
        textField.text = value
    }
}

extension SimpleTextfieldCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(textField)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

// MARK: - UITextFieldDelegate
extension SimpleTextfieldCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }

        delegate?.didChangeValue(propertyName: propertyName,
                                 value: text.replacingCharacters(in: range, with: string))
        return true
    }
}