//
//  EditProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

final class EditProfileView: UIView, ViewCodable {
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(textLabel: "editar perfil", imageStrig: "edit-profile")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubViews([headerView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
