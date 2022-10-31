//
//  RouterTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 30/10/22.
//

import XCTest
@testable import Mart

final class RouterTests: XCTestCase {
    var sut: Router!
    let session = URLSessionMock()
    
    override func setUp() {
        super.setUp()
        session.nextDataTask.resetFlags()
        sut = Router(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testGetRequestWithURL() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        XCTAssertEqual(session.lastURL, CategoriesApi.list.getFullURL())
    }
    
    func testGetResumeCalled() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        XCTAssertTrue(session.nextDataTask.resumeCalled)
    }
    
    func testGetShouldReturnData() {
        session.nextData = CategoriesJsonData
        
        sut.request(CategoriesApi.list) { data, response, error in
            XCTAssertEqual(self.session.nextData, data)
        }
    }
    
    func testCancellCalled() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        sut.cancel()
        
        XCTAssertTrue(session.nextDataTask.cancelCalled)
    }
}
