//
//  HomeEndpoint.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/10/22.
//

import Foundation

public enum HomeApi {
    case get
    case getLastSearch
}

extension HomeApi: EndpointType {
    var path: String {
        switch self {
        case .get: return "home"
        case .getLastSearch: return "home/last-search"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .get: return "home"
        case .getLastSearch: return "home-last-search"
        }
    }
}

struct HomeResponse: Codable, Equatable {
    
}
