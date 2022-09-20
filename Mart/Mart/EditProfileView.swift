//
//  EditProfileView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

private enum CellType {
    case textField(Profile.Field)
    case doubleTextField(Profile.Field, Profile.Field)
    case checkbox(Profile.Field)
    case button
    
    static func getCellType(from field: Profile.Field) -> CellType? {
        switch field {
        case .name:
            return .textField(field)
        case .address:
            return .textField(field)
        case .number:
            return .doubleTextField(.number, .complement)
        case .complement:
            return nil
        case .email:
            return .textField(field)
        case .cellphone:
            return .textField(field)
        case .canShareWhatsapp:
            return .checkbox(field)
        }
    }
}

protocol EditProfileViewDelegate: AnyObject {

}

final class EditProfileView: UIView, ViewCodable {
    
    private weak var delegate: EditProfileViewDelegate?
    private var profile: Profile?
    private var values: [(field: Profile.Field, value: Any)] = []
    private var cells: [CellType] = []
    
    private lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()

    init(delegate: EditProfileViewDelegate?, profile: Profile) {
        self.delegate = delegate
        self.profile = profile
        super.init(frame: .zero)
        setupView()
        setupValues()
        setupCells()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubViews([tableview])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        tableview.contentInset = .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    private func setupHeaderView() -> HeaderView {
        let view = HeaderView(textLabel: "editar perfil", imageStrig: "edit-profile")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
        return view
    }
    
    private func setupValues() {
        
    }
    
    private func setupCells() {
        
    }
}

extension EditProfileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupHeaderView()
    }
}

extension EditProfileView: UITableViewDelegate { }
