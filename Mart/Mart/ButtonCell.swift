//
//  ButtonCell.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/09/22.
//

import UIKit

public protocol ButtonCellDelegate: AnyObject {
    func didTapButton()
}

public final class ButtonCell: UITableViewCell {
    
    public weak var delegate: ButtonCellDelegate?
    
    private lazy var button: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        element.configuration = .setButtonConfiguration(backgroundColor: .init(rgb: 0xFFC13B), title: "Atualizar dados", font: .f18PrimarySemiBold, textColor: .black)
        return element
    }()
    
    @objc
    func didTapButton() {
        delegate?.didTapButton()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    public func setTitle(_ title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
    }
}

extension ButtonCell: ViewCodable {
    
    public func buildViewHierarchy() {
        contentView.addSubview(button)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
