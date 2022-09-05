//
//  TableFooterView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/09/22.
//

import UIKit

protocol TableFooterViewDelegate: AnyObject {
    func didTapCheckout()
}

class TableFooterView: UIView, ViewCodable {
    
    weak var delegate: TableFooterViewDelegate?
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total: R$ 0.00"
        label.textColor = .black
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(rgb: 0xFF6E40)
        return view
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .setButtonConfiguration(backgroundColor: .init(rgb: 0xFFC13B), title: "check-out", font: .f18PrimarySemiBold, textColor: .black)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(totalLabel)
        addSubview(lineView)
        addSubview(checkoutButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 8),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            
            checkoutButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func didTapButton() {
        delegate?.didTapCheckout()
    }
}
