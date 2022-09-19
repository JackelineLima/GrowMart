//
//  ProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

final class ProfileView: UIView, ViewCodable {
    
    private lazy var titleProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meu perfil"
        label.textColor = .black
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
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
