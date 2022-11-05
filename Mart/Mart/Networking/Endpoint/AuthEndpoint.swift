//
//  AuthEndpoint.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 29/10/22.
//

import Foundation

// MARK: - Request
public enum AuthApi {
    case auth(login: String, password: String)
}

extension AuthApi: EndpointType {
    
    var path: String {
        switch self {
        case .auth: return "auth"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .auth: return "auth"
        }
    }
}

// MARK: - Response
struct AuthResponse: Codable, Equatable {
    var id: String?
    var name: String?
    var email: String?
    var phone: String?
}
