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
        button.configuration = setButtonConfiguration(backgroundColor: .blue, title: "ENTRAR COM FACEBOOK", icon: UIImage(named: "icon-facebook"))
        return button
    }()
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = setButtonConfiguration(backgroundColor: .red, title: "ENTRAR COM FACEBOOK", icon: UIImage(named: "icon-google"))
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setButtonConfiguration(backgroundColor: UIColor,
                                title: String,
                                icon: UIImage?) -> UIButton.Configuration {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.image = icon
        configuration.titlePadding = 10
        configuration.imagePadding = 30
        configuration.background.backgroundColor = backgroundColor
        return configuration
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
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 56),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -56),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        stackView.setCustomSpacing(16, after: facebookButton)
    }
}
