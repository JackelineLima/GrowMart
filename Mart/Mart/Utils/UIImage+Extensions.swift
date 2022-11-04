//
//  UIImage+Extensions.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 10/09/22.
//

import UIKit

public extension UIImage {
    
    static func render(size: CGSize, _ draw: () -> Void) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        
        draw()
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    static func make(size: CGSize, color: UIColor = .white) -> UIImage? {
        return render(size: size) {
            color.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
        }
    }
    
    
    enum SystemImage: String {
        case starFill = "star.fill"
        case trashFill = "trash.fill"
        case sliderHorizontal3 = "slider.horizontal.3"
        case xmark = "xmark"
        }
        
        static func makeWith(systemImage: SystemImage,
                             color: UIColor? = nil) -> UIImage? {
            var image = UIImage(systemName: systemImage.rawValue)

            if let color = color {
                image = image?.withTintColor(color, renderingMode: .alwaysOriginal)
            }
            
            return image
        }

        static func makeWith(name: String,
                             color: UIColor? = nil) -> UIImage? {
            var image = UIImage(named: name)

            if let color = color {
                image = image?.withTintColor(color, renderingMode: .alwaysOriginal)
            }
            
            return image
        }
}
