//
//  NetworkRouterMock.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 30/10/22.
//

import Foundation
@testable import Mart

class NetworkRouterMock: NetworkRouter {
    var mockedData: Data?
    var mockedURLResponse: URLResponse?
    var mockedError: Error?
    
    var requestCalled = false
    func request(_ endpoint: EndpointType, completion: @escaping NetworkRouterCompletion) {
        requestCalled = true
        completion(mockedData, mockedURLResponse, mockedError)
    }
    
    var cancelCalled = false
    
    func cancel() {
        cancelCalled = true
    }
}
