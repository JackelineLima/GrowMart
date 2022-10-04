//
//  UIView+Extensions.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/08/22.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    public func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    
    public static func drawCircleBackgroundView(with color: UIColor,
                                                contrastColor: UIColor = .white,
                                                heightPercent: CGFloat = 0.6,
                                                circleCenterHeight: CGFloat = 0) -> UIView {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundView.backgroundColor = color
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: circleCenterHeight),
                                      radius: CGFloat(UIScreen.main.bounds.height * heightPercent),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = contrastColor.cgColor
        shapeLayer.strokeColor = contrastColor.cgColor
        shapeLayer.lineWidth = 3.0
        backgroundView.layer.addSublayer(shapeLayer)
        return backgroundView
    }
    
    public func drawCircleBackgroundView(view: UIView, circleColor: UIColor = UIColor.yellow) {
        let radius = CGFloat(view.frame.width * 2)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: (view.frame.width / 2),
                                                         y: view.frame.maxY - (radius + 2)),
                                      radius: radius,
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = circleColor.cgColor
        shapeLayer.strokeColor = circleColor.cgColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
    }
}
