//
//  CheckoutView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import UIKit

protocol CheckoutViewDelegate: AnyObject {
    func remove(product: Product)
    func didTapCheckout()
}

final class CheckoutView: UIView, ViewCodable {
    
    weak var delegate: CheckoutViewDelegate?
    
    var viewModel: CheckoutViewModelProtocol
    
    private lazy var lineView: LineNavigationView = {
        let view = LineNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footerView = TableFooterView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 160))
    
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
        
        self.viewModel.reloadTableView = {
            self.reloadTableView()
        }
        backgroundColor = .white
        footerView.delegate = self
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

extension CheckoutView: TableFooterViewDelegate {
    
    func didTapCheckout() {
        delegate?.didTapCheckout()
    }
}
