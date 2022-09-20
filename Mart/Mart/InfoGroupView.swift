//
//  InfoGroup.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

class InfoGroupView: UIStackView {
    
    private let title: String
    private let infos: [(leftValue: String, rightValue: String)]
    private let footerMessage: String?
    private var labelValues = [LabelValueView]()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .init(rgb: 0x1E3D59)
        label.textAlignment = .center
        label.font = UIFontStyle.customFont(name: .f14PrimaryBold)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xA0A4A8)
        return element
    }()
    
    private lazy var footerLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFontStyle.customFont(name: .f12PrimarySemiBold)
        element.textColor = .black
        element.numberOfLines = 0
        return element
    }()
    
    init(title: String, infos: [(leftValue: String, rightValue: String)], footerMessage: String?) {
        self.title = title
        self.infos = infos
        self.footerMessage = footerMessage
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        axis = .vertical
        distribution = .fillProportionally
        alignment = .center
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0x2B577F).cgColor
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        spacing = 8
        setCustomSpacing(16, after: lineView)
        
        dataLabel.text = title
        footerLabel.text = footerMessage
        
        addSubviews()
        setupConstraints()

    }
    
    func addSubviews() {
        addArrangedSubview(dataLabel)
        
        infos.forEach { info in
            let element = LabelValueView(leftValue: info.leftValue,
                                         rightValue: info.rightValue)
            labelValues.append(element)
            addArrangedSubview(element)
        }
        
        if let value = footerMessage, !value.isEmpty {
            addArrangedSubview(lineView)
            addArrangedSubview(footerLabel)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dataLabel.widthAnchor.constraint(equalTo: widthAnchor),
            dataLabel.topAnchor.constraint(equalTo: topAnchor),
            dataLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        labelValues.forEach({ element in
            NSLayoutConstraint.activate([
                element.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                element.heightAnchor.constraint(equalToConstant: 30)
            ])
        })

        if let value = footerMessage, !value.isEmpty {
            NSLayoutConstraint.activate([
                lineView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                lineView.heightAnchor.constraint(equalToConstant: 1),
                footerLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                footerLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
    }
}
