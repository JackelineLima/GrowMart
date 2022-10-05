//
//  AddProductView.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

private enum CellType {
    case textField(Product.Field)
    case selector(Product.Field)
    case button
    
    static func getCellType(from field: Product.Field) -> CellType? {
        switch field {
        case .category, .condition:
            return .selector(field)
        default:
            return .textField(field)
        }
    }
}

protocol AddProductViewDelegate: AnyObject {
    func addProduct(_ product: Product)
}

final class AddProductView: BaseViewTable {
    
    weak var delegate: AddProductViewDelegate?
    
    private var product = Product()
    private var values: [(field: Product.Field, value: Any)] = []
    private var cellsType: [CellType] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupValues()
        setupCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func buildViewHierarchy() {
        super.buildViewHierarchy()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        
        backgroundColor = .white
        setTableViewDelegate(delegate: self)
        setTableViewDataSource(dataSource: self)
        registerTableViewCells()
        setupTableContentInset()
    }
    
    private func registerTableViewCells() {
        tableViewComponent.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
        tableViewComponent.register(SimpleTextfieldCell.self, forCellReuseIdentifier: SimpleTextfieldCell.reuseIdentifier)
        tableViewComponent.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.reuseIdentifier)
    }
    
    private func setupValues() {
        values = [
            (field: .name, value: product.name ?? ""),
            (field: .price, value: product.price ?? ""),
            (field: .category, value: product.category ?? ""),
            (field: .size, value: product.size ?? ""),
            (field: .condition, value: product.condition ?? ""),
            (field: .brand, value: product.brand ?? ""),
            (field: .description, value: product.description ?? "")
        ]
    }
    
    private func setupCells() {
        cellsType.removeAll()
        values.forEach { item in
            if let cellType: CellType = .getCellType(from: item.field) {
                cellsType.append(cellType)
            }
        }
        cellsType.append(.button)
    }
    
    private func updateProduct(field: Product.Field, value: Any?) {
        switch field {
        case .name:
            product.name = value as? String
        case .price:
            product.price = value as? String
        case .category:
            product.category = value as? String
        case .size:
            product.size = value as? String
        case .condition:
            product.condition = value as? String
        case .brand:
            product.brand = value as? String
        case .description:
            product.description = value as? String
        }
    }
    
    private func getFieldValue(field: Product.Field) -> Any? {
        switch field {
        case .name:
            return product.name
        case .price:
            return product.price
        case .category:
            return product.category
        case .size:
            return product.size
        case .condition:
            return product.condition
        case .brand:
            return product.brand
        case .description:
            return product.description
        }
    }
    
    private func getOptions(field: Product.Field) -> [String] {
        switch field {
        case .condition:
            return ["Novo", "Usado"]
        case .category:
            return ["Roupas", "Acessórios", "Outros"]
        default:
            return []
        }
    }
}

extension AddProductView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsType.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellsType[indexPath.row] {
        case let .textField(field):
            guard let cell: SimpleTextfieldCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            cell.propertyName = field.rawValue
            cell.delegate = self
            cell.setData(placeholder: field.getFormattedName(),
                         value: getFieldValue(field: field) as? String)
            return cell
        case let .selector(field):
            guard let cell: SelectorCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }

            cell.propertyName = field.rawValue
            cell.delegate = self
            cell.setData(placeholder: field.getFormattedName(),
                         value: getFieldValue(field: field) as? String,
                         options: getOptions(field: field))
            return cell
        case .button:
            guard let cell: ButtonCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            cell.setTitle("publicar", color: .black)
            cell.delegate = self
            return cell
        }
    }
}

extension AddProductView: ButtonCellDelegate {
    public func didTapButton() {
        print("didTapButton")
    }
}

extension AddProductView: SimpleTextfieldCellDelegate, SelectorCellDelegate {
    public func didChangeValue(propertyName: String?, value: String) {
        guard let propertyName = propertyName,
              let field = Product.Field(rawValue: propertyName) else {
            return
        }
        
        updateProduct(field: field, value: value)
    }
}
