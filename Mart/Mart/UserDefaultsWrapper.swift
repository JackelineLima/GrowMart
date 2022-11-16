//
//  UserDefaultsWrapper.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 07/11/22.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: self.key) as? T ?? defaultValue
        }
        set {
            return UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
}
