//
//  NetworkEnvironment.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/10/22.
//

import Foundation

enum NetworkEnvironment: String {
    case debug = "Debug"
    case mock = "Mock"
    case release = "Release"
    
    func getBaseUrl() -> String {
        switch self {
        case .debug, .release: return "https://growmart-api.herokuapp.com/v1/"
        case .mock: return ""
        }
    }
}
