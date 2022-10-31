//
//  URLSessionDataTaskSpy.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 30/10/22.
//

import Foundation
@testable import Mart

class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    private (set) var resumeCalled = false
    private (set) var cancelCalled = false
    
    func resume() {
        resumeCalled = true
    }
    
    func cancel() {
        cancelCalled = true
    }
    
    func resetFlags() {
        resumeCalled = false
        cancelCalled = false
    }
}
