//
//  CategoriesEndpoint.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/10/22.
//

import Foundation

public enum CategoriesApi {
    case get(id: Int)
    case list
}

extension CategoriesApi: EndpointType {
    
    var path: String {
        switch self {
        case let .get(id): return "categorie/\(id)"
        case .list: return "categories"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .get: return "categorie"
        case .list: return "categories"
        }
    }
}

struct CategoriesResponse: Codable, Equatable {
    var entries: [CategoryResponse]?
}

struct CategoryResponse: Codable, Equatable {
    var id: String?
    var name: String?
    var image: String?
}
