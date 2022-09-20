//
//  GrowButton.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

enum GrowButtonStyle {
    case buttonWithoutBackground
    case buttonBordered
    
    public var backgroundColor: UIColor {
        switch self {
        case .buttonWithoutBackground:
            return .init(rgb: 0xFFC13B)
        case .buttonBordered:
            return.init(rgb: 0xFFFFFF)
        }
    }
    
    public var borderColor: UIColor {
        switch self {
        case .buttonWithoutBackground:
            return .clear
        case .buttonBordered:
            return .init(rgb: 0xFFC13B)
        }
    }
    
    public var titleColor: UIColor {
        switch self {
        case .buttonWithoutBackground:
            return .black
        case .buttonBordered:
            return .black
        }
    }
}

class GrowButton: UIButton {
    
    var onTapAction: (() -> Void)?
    let style: GrowButtonStyle
    let title: String
    let imageString: String?
    
    init(style: GrowButtonStyle = .buttonWithoutBackground, title: String, imageString: String? = nil) {
        self.title = title
        self.style = style
        self.imageString = imageString
        super.init(frame: .zero)
        setupLayout()
    }
    
    func setupLayout() {
        setTitle(title, for: .normal)
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = UIFontStyle.customFont(name: .f18PrimaryMedium)
        backgroundColor = style.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = style.borderColor.cgColor
        layer.cornerRadius = 5
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        if let imageString = imageString {
            semanticContentAttribute = .forceRightToLeft
            imageView?.contentMode = .scaleAspectFit
            setImage(UIImage(named: imageString), for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWidth = frame.width
        imageEdgeInsets = UIEdgeInsets(top: 0, left: buttonWidth/2, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        onTapAction?()
    }
}
