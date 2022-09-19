//
//  EditProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

final class EditProfileView: UIView, ViewCodable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {}
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {
        backgroundColor = .red
    }
}
