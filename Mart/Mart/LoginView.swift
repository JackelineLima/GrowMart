//
//  LoginView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/08/22.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func continueButtonFacebook()
    func continueButtonGoogle()
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 27
        return stackView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var bagsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bags")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.configuration = .setButtonConfiguration(backgroundColor: .init(rgb: 0x4267B2), title: "ENTRAR COM FACEBOOK", icon: UIImage(named: "icon-facebook"), font: .f12PrimarySemiBold, textColor: .white)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueButtonFacebook), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.configuration = .setButtonConfiguration(backgroundColor: .init(rgb: 0xDB4437), title: "ENTRAR COM GOOGLE", icon: UIImage(named: "icon-google"), font: .f12PrimarySemiBold, textColor: .white)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueButtonGoogle), for: .touchUpInside)
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func continueButtonFacebook() {
        delegate?.continueButtonFacebook()
    }
    
    @objc
    private func continueButtonGoogle() {
        delegate?.continueButtonGoogle()
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
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        stackView.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        backgroundColor = .white
        stackView.setCustomSpacing(16, after: facebookButton)
    }
}
