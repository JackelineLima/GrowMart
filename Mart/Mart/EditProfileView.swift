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
    func updateProfile(data: Profile)
}

final class EditProfileView: UIView, ViewCodable {
    
    private weak var delegate: EditProfileViewDelegate?
    private var profile: Profile?
    private var values: [(typeTextfield: Profile.Field, value: Any)] = []
    private var cellsType: [CellType] = []
    
    private lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
//        table.register(CheckboxCell.self, forCellReuseIdentifier: CheckboxCell.reuseIdentifier)
        table.register(CustomTextFieldCell.self, forCellReuseIdentifier: CustomTextFieldCell.reuseIdentifier)
        table.register(DoubleCustomTextFieldCell.self, forCellReuseIdentifier: DoubleCustomTextFieldCell.reuseIdentifier)
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
    
    private func setupHeaderView() -> UIView {
        let headerView = UIView()
        let view = HeaderView(textLabel: "editar perfil", imageStrig: "edit-profile")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        headerView.addSubview(view)
        view.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 32).isActive = true
        view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -32).isActive = true
        view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        return headerView
    }
    
    private func setupValues() {
        values = [
            (typeTextfield: .name, value: profile?.name ?? ""),
            (typeTextfield: .address, value: profile?.address ?? ""),
            (typeTextfield: .number, value: profile?.number ?? ""),
            (typeTextfield: .complement, value: profile?.complement ?? ""),
            (typeTextfield: .email, value: profile?.email ?? ""),
            (typeTextfield: .cellphone, value: profile?.cellphone ?? ""),
            (typeTextfield: .canShareWhatsapp, value: profile?.canShareWhatsapp ?? false)
        ]
    }
    
    private func setupCells() {
        cellsType.removeAll()
        values.forEach { item in
            if let cellType: CellType = .getCellType(from: item.typeTextfield) {
                cellsType.append(cellType)
            }
        }
        cellsType.append(.button)
    }
    
    private func setupCellType(for index: IndexPath) -> CellType? {
        guard index.row < cellsType.count else {
            return nil
        }
    
        return cellsType[index.row]
    }
    
    private func updateProfile(field: Profile.Field, value: Any?) {
        switch field {
        case .name:
            profile?.name = value as? String
        case .address:
            profile?.address = value as? String
        case .number:
            profile?.number = value as? String
        case .complement:
            profile?.complement = value as? String
        case .email:
            profile?.email = value as? String
        case .cellphone:
            profile?.cellphone = value as? String
        case .canShareWhatsapp:
            profile?.canShareWhatsapp = value as? Bool
        }
    }
    
    private func getFieldValue(field: Profile.Field) -> Any? {
        switch field {
        case .name:
            return profile?.name
        case .address:
            return profile?.address
        case .number:
            return profile?.number
        case .complement:
            return profile?.complement
        case .email:
            return profile?.email
        case .cellphone:
            return profile?.cellphone
        case .canShareWhatsapp:
            return profile?.canShareWhatsapp
        }
    }
    
    private func validateDelegates(propertyName: String?, value: Any?) {
        guard let propertyName = propertyName,
              let field = Profile.Field(rawValue: propertyName) else {
            return
        }
        
        updateProfile(field: field, value: value)
    }
}

extension EditProfileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = setupCellType(for: indexPath) else { return UITableViewCell() }
        
        switch cellType {
        case .textField(let field):
            guard let cell: CustomTextFieldCell = .createCell(for: tableView, at: indexPath) else { return UITableViewCell() }
            cell.propertyName = field.rawValue
            cell.delegate = self
            cell.setData(title: field.getFormattedName(),
                         value: getFieldValue(field: field) as? String)
            return cell
        case .doubleTextField(let leftTitle, let rightTitle):
            guard let cell: DoubleCustomTextFieldCell = .createCell(for: tableView, at: indexPath) else { return UITableViewCell() }
            cell.leftFieldPropertyName = leftTitle.rawValue
            cell.rightFieldPropertyName = rightTitle.rawValue
            cell.delegate = self
            cell.setData(leftTitle: leftTitle.getFormattedName(),
                         leftValue: getFieldValue(field: leftTitle) as? String,
                         rightTitle: rightTitle.getFormattedName(),
                         rightValue: getFieldValue(field: rightTitle) as? String)
            return cell
        case .checkbox(let field):
            return UITableViewCell()
        case .button:
            guard let cell: ButtonCell = .createCell(for: tableView, at: indexPath) else { return UITableViewCell() }
            cell.delegate = self
            return cell
        }
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

extension EditProfileView: CustomTextFieldCellDelegate, DoubleCustomTextFieldCellDelegate {
    
    func didChangeValue(propertyName: String?, value: String) {
        validateDelegates(propertyName: propertyName, value: value)
    }
}

extension EditProfileView: ButtonCellDelegate {
    
    func didTapButton() {
        guard let profile = profile else { return }
        delegate?.updateProfile(data: profile)
    }
}
