//
//  CustomTextFieldCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/09/22.
//

import UIKit

public protocol CustomTextFieldCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class CustomTextFieldCell: UITableViewCell {
    
    public weak var delegate: CustomTextFieldCellDelegate?
    public var propertyName: String?

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f14PrimaryMedium)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var textField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .none
        element.font = UIFontStyle.customFont(name: .f14PrimaryMedium)
        element.delegate = self
        return element
    }()
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0x1E3D59)
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
    
    public func setData(title: String, value: String?) {
        titleLabel.text = title
        
        textField.placeholder = title
        textField.text = value
    }
}

extension CustomTextFieldCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(lineView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 47),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleLabel.heightAnchor.constraint(equalToConstant: 23),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 47),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textField.heightAnchor.constraint(equalToConstant: 31),

            lineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

extension CustomTextFieldCell: UITextFieldDelegate {
    
    //Chama sempre que o campo de texto muda
    public func textField(_ textField: UITextField,
                          //deve mudar os caracteres em (local/tamanho que mudou)
                          shouldChangeCharactersIn range: NSRange,
                          //String de substitui????o (e o que mudou)
                          replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }

        delegate?.didChangeValue(propertyName: propertyName,
                                 value: text.replacingCharacters(in: range, with: string))
        return true
    }
}
