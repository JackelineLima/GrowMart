//
//  TableFooterView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/09/22.
//

import UIKit

class TableFooterView: UIView, ViewCodable {
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total: R$ 0.00"
        label.textColor = .black
        return label
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: topAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
