//
//  SegmentedBar.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 10/09/22.
//

import UIKit

protocol SegmentedBarDelegate: AnyObject {
    func didTapSegmented(index: Int)
}

class SegmentedBar: UISegmentedControl {
    
    weak var delegate: SegmentedBarDelegate?
    let size = CGSize(width: 1, height: 45)
    let lineWidth: CGFloat = 5
    let itemsLayout: [UIControl.State] = [
        .normal,
        .selected,
        .highlighted,
        [.highlighted, .selected]
    ]
    
    init(collections: [Any]?, index: Int) {
        super.init(items: collections)
        setupLayout(index: index)
    }
    
    func setupLayout(index: Int) {
        clipsToBounds = false
        selectedSegmentIndex = index
        setTitleTextAttributes([NSAttributedString.Key.font: UIFontStyle.customFont(name: .f18PrimarySemiBold)], for: .normal)
        addTarget(self, action: #selector(didTap(_:)), for: .valueChanged)
        
        itemsLayout.forEach { state in
            let image = background(for: state)
            setBackgroundImage(image, for: state, barMetrics: .default)
            
            let divider = divider(leftState: state, rightState: state)
            setDividerImage(divider, forLeftSegmentState: state, rightSegmentState: state, barMetrics: .default)
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func background(color: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            color.setFill()
            
            let rect = CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth)
            UIRectFill(rect)
        }
    }
    
    private func divider(leftColor: UIColor, rightColor: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            UIColor.clear.setFill()
        }
    }
    
    private func background(for state: UIControl.State) -> UIImage? {
        return background(color: color(for: state))
    }

    private func divider(leftState: UIControl.State, rightState: UIControl.State) -> UIImage? {
        return divider(leftColor: color(for: leftState), rightColor: color(for: rightState))
    }
    
    private func color(for state: UIControl.State) -> UIColor {
        switch state {
        case .selected, [.selected, .highlighted]:
            return UIColor(rgb: 0xFFC13B)
        case .highlighted:
            return UIColor(rgb: 0xFFC13B).withAlphaComponent(0.5)
        default:
            return .clear
        }
    }
    
    @objc func didTap(_ action: UISegmentedControl) {
        delegate?.didTapSegmented(index: action.selectedSegmentIndex)
    }
}
