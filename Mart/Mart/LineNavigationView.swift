//
//  LineNavigation.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import Foundation
import UIKit

class LineNavigationView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(rgb: 0xFFC13B)
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(rgb: 0xE8E8E8)
        addSubview(backgroundView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            backgroundView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
