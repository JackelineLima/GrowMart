//
//  DefaultViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 06/09/22.
//

import Foundation
import UIKit

public class DefaultViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func configure() {
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_navigation"))
        navigationItem.setHidesBackButton(true, animated: true)

        buildViewHierarchy()
        setupConstraints()
    }
    
    func setupRightButtonNavigation(action: Selector?) {
        let spacer = UIBarButtonItem(systemItem: .fixedSpace)
        spacer.width = 16
        let button = UIBarButtonItem(image: UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
        self.navigationItem.setRightBarButtonItems([spacer, button], animated: false)
    }
    
    func setupLeftButtonNavigation(useBarItem: Bool = false, action: Selector?) {
        let spacer = UIBarButtonItem(systemItem: .fixedSpace)
        spacer.width = 16
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
        self.navigationItem.setLeftBarButtonItems([spacer, backButton], animated: false)
    }
    
    private lazy var lineView: LineNavigationView = {
        let view = LineNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func buildViewHierarchy() {
        view.addSubview(lineView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func isHiddenLineView() {
        lineView.isHidden = true
    }
}
