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
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var bagsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "bags")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = setButtonConfiguration(backgroundColor: .init(rgb: 0x4267B2), title: "ENTRAR COM FACEBOOK", icon: UIImage(named: "icon-facebook"), font: .f12PrimarySemiBold)
        button.layer.cornerRadius = 8
        return button
    }()
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = setButtonConfiguration(backgroundColor: .init(rgb: 0xDB4437), title: "ENTRAR COM GOOGLE", icon: UIImage(named: "icon-google"), font: .f12PrimarySemiBold)
        button.layer.cornerRadius = 8
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setButtonConfiguration(backgroundColor: UIColor, title: String, icon: UIImage?, font: UIFontStyle ) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString(title, attributes: .init([NSAttributedString.Key.font: UIFontStyle.customFont(name: font)]))
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
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75),
            facebookButton.heightAnchor.constraint(equalToConstant: 40),
            googleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        stackView.setCustomSpacing(16, after: facebookButton)
    }
}
