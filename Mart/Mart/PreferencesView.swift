//
//  Preferences.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import Foundation
import UIKit

final class PreferencesView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
        backgroundColor = .red
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PreferencesView: ViewCodable {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
