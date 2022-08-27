//
//  HomeViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var contentView = HomeView()
    private let coordinator: HomeCoordinatorProtocol

    init(coordinator: HomeCoordinatorProtocol) {
      self.coordinator = coordinator
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
