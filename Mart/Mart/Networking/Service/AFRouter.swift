//
//  AFRouter.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 26/10/22.
//

import Foundation
import Alamofire

class AFRouter: Router {
    override func request(_ endpoint: EndpointType, completion: @escaping NetworkRouterCompletion) {
        var parameters: Parameters?
        switch endpoint.task {
        case let .requestParameters(_, _, urlParameters):
            parameters = urlParameters
        default:
            break
        }
        AF.request(endpoint.getFullURL(),
                   method: .get,
                   parameters: parameters,
                   headers: nil).response { response in
            completion(response.data, response.response, response.error)
        }
    }
    
    override func cancel() {
        AF.cancelAllRequests()
    }
}
