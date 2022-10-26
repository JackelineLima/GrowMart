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
        AF.request(endpoint.getFullURL(),
                   method: .get,
                   parameters: [:],
                   headers: nil).response { response in
            completion(response.data, response.response, response.error)
        }
    }
    
    override func cancel() {
        AF.cancelAllRequests()
    }
}
