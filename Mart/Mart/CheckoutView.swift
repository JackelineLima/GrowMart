//
//  CheckoutView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import UIKit

protocol CheckoutViewDelegate: AnyObject {
    func remove(product: Product)
}

final class CheckoutView: UIView, ViewCodable {
    
    weak var delegate: CheckoutViewDelegate?
    
    let viewModel: CheckoutViewModelProtocol
    
    private lazy var lineView: LineNavigation = {
        let view = LineNavigation()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var footerView = TableFooterView()
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = footerView
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(CheckoutTableViewCell.self, forCellReuseIdentifier: CheckoutTableViewCell.identifier)
        tb.contentInset = .init(top: 32, left: 0, bottom: 145, right: 0)
        return tb
    }()
    
    init(viewModel: CheckoutViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension CheckoutView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutTableViewCell.identifier, for: indexPath) as? CheckoutTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.setupCell(with: viewModel.product[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension CheckoutView: CheckoutTableViewCellDelegate {
    
    func remove(product: Product) {
        delegate?.remove(product: product)
    }
}
