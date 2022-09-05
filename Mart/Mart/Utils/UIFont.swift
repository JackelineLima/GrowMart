//
//  UIFont.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 21/08/22.
//

import UIKit

public struct UIFontWeight {
    public static let primarySemiBold: String = "Nunito-SemiBold"
    public static let primaryExtraBold: String = "Nunito-ExtraBold"
    public static let primaryMedium: String = "Nunito-Medium"
    public static let primaryRegular: String = "Nunito-Regular"
    public static let primaryBold: String = "Nunito-Bold"
}

public enum UIFontStyle {
    case f10PrimaryRegular
    case f14PrimaryRegular
    case f12PrimarySemiBold
    case f14PrimaryMedium
    case f16PrimaryMedium
    case f18PrimaryMedium
    case f25PrimaryExtraBold
    case f30PrimaryExtraBold
    
    public var weight: String {
        switch self {
        case .f10PrimaryRegular, .f14PrimaryRegular:
            return UIFontWeight.primaryRegular
        case .f12PrimarySemiBold:
            return UIFontWeight.primarySemiBold
        case .f14PrimaryMedium, .f18PrimaryMedium, .f16PrimaryMedium:
            return UIFontWeight.primaryMedium
        case .f30PrimaryExtraBold, .f25PrimaryExtraBold:
            return UIFontWeight.primaryExtraBold
        }
    }
    
    public var size: CGFloat {
        var size: CGFloat = 0
        switch self {
        case .f10PrimaryRegular:
            size = 10
        case .f12PrimarySemiBold:
            size = 12
        case .f14PrimaryMedium, .f14PrimaryRegular:
            size = 14
        case .f16PrimaryMedium:
            size = 16
        case .f18PrimaryMedium:
            size = 18
        case .f25PrimaryExtraBold:
            size = 25
        case .f30PrimaryExtraBold:
            size = 30
        }
        return size
    }
    
    static func customFont(name: UIFontStyle) -> UIFont {
        guard let font = UIFont(name: name.weight, size: name.size) else {
            fatalError("Unable to initialize font '\(name.weight)' (\(name.size))")
        }
        return font
    }
}
