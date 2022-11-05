//
//  EndpointType.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/10/22.
//

import Foundation

//ENDPOINTBASE

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
    func getMockName() -> String
    func getFullURL() -> URL
}

extension EndpointType {
    
    private var environment: NetworkEnvironment {
        guard let schemeName = Bundle.main.infoDictionary?["CURRENT_SCHEME_NAME"] as? String,
            let environment = NetworkEnvironment(rawValue: schemeName) else {
            fatalError("schemeName could not be configured.")
        }
        return environment
    }
    
    private var baseURLDefault: URL {
        switch environment {
        case .mock:
            guard let path = Bundle.main.path(forResource: getMockName(), ofType: "json") else {
                fatalError("Mock not found.")
            }
            
            return NSURL.fileURL(withPath: path)
        case .debug, .release:
            guard let url = URL(string: baseURL) else {
                fatalError("URL not found.")
            }
            return url
        }
    }
    
    var baseURL: String {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        .request
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    func getFullURL() -> URL {
        if environment == .mock {
            return baseURLDefault
        } else {
            return baseURLDefault.appendingPathComponent(path)
        }
    }
}
