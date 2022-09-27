//
//  UITableViewCell+Extensions.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/09/22.
//

import UIKit

extension UITableViewCell {
    
    public static var reuseIdentifier: String {
        String(describing: self)
    }
    
    public class func createCell<T: UITableViewCell>(
        for tableView: UITableView,
        at indexPath: IndexPath) ->T? {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
