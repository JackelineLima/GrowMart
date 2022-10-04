//
//  BaseViewWithTable.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

class BaseViewTable: UIView, ViewCodable {
    
    internal lazy var tableViewComponent: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func buildViewHierarchy() {
        addSubview(tableViewComponent)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableViewComponent.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableViewComponent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableViewComponent.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableViewComponent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    public func setTableViewDataSource(dataSource: UITableViewDataSource?) {
        tableViewComponent.dataSource = dataSource
    }
    
    public func setTableViewDelegate(delegate: UITableViewDelegate?) {
        tableViewComponent.delegate = delegate
    }
    
    public func setupTableContentInset() {
        tableViewComponent.contentInset = .init(top: 32,
                                       left: 0,
                                       bottom: 32,
                                       right: 0)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewComponent.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.tableViewComponent.layoutIfNeeded()
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        setupTableContentInset()
        UIView.animate(withDuration: 0.5) {
            self.tableViewComponent.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
}
