//
//  UIImageView+Extensions.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 12/09/22.
//

import UIKit

extension UIImageView {
    
    func addImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
}
