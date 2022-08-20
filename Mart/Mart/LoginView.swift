//
//  LoginView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/08/22.
//

import UIKit

class LoginView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 27
        return stackView
    }()
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        return view
    }()
    private lazy var bagsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "bags")
        return view
    }()
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENTRAR COM FACEBOOK", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENTRAR COM GOOGLE", for: .normal)
        button.backgroundColor = .red
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(bagsImageView)
        stackView.addArrangedSubview(facebookButton)
        stackView.addArrangedSubview(googleButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 64),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -64),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        stackView.setCustomSpacing(16, after: facebookButton)
    }
}
