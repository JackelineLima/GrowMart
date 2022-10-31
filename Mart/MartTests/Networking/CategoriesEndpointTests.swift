//
//  CategoriesEndpointTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 30/10/22.
//

import XCTest
@testable import Mart

final class CategoriesEndpointTests: XCTestCase {
    
    func testCategoriesApiForGet() {
        let sut = CategoriesApi.get(id: 1)
        
        XCTAssertEqual(sut.getMockName(), "categorie")
        XCTAssertEqual(sut.path, "categorie/1")
    }
    
    func testCategoriesApiForList() {
        let sut = CategoriesApi.list
        
        XCTAssertEqual(sut.getMockName(), "categories")
        XCTAssertEqual(sut.path, "categories")
    }
    
    func testDefaultProtocolImplementations() {
        let sut = CategoriesApi.list
        
        XCTAssertEqual(sut.baseURL, URL(string: NetworkEnvironment.debug.getBaseUrl()))
        XCTAssertEqual(sut.httpMethod, .get)
        XCTAssertNil(sut.headers)
        XCTAssertEqual(sut.getFullURL(), URL(string: "https://growmart-api.herokuapp.com/v1/categories"))
    }
}
