//
//  URLSessionMock.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 30/10/22.
//

import Foundation
@testable import Mart

class URLSessionMock: URLSessionProtocol {
    
    var nextDataTask = URLSessionDataTaskSpy()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!,
                               statusCode: 200,
                               httpVersion: "HTTP/1.1",
                               headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping NetworkRouterCompletion) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successResponse(request: request), nextError)
        return nextDataTask
    }
}
