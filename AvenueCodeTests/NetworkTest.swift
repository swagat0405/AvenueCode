//
//  NetworkTest.swift
//  AvenueCodeTests
//
//  Created by Swagat Mishra on 6/3/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import XCTest
@testable import AvenueCode

class NetworkTest: XCTestCase {
    
    var systemUnderTest: NetworkManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = NetworkManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testGoogleMapAPIMultiplResult() {
        //given
        let location = "SpringField"
        let promise = expectation(description: "Multiple locations found")
        //when
        systemUnderTest.search(location: location) { (locations) in
            if locations.count > 1 {
                promise.fulfill()
            }
            else {
                XCTFail("Network Test -- Failed")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGoogleMapAPISingleResult() {
        //given
        let location = "Eastover Ridge"
        let promise = expectation(description: "Single location found")
        //when
        systemUnderTest.search(location: location) { (locations) in
            if locations.count == 1 {
                promise.fulfill()
            }
            else {
                XCTFail("Network Test -- Failed")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGoogleMapAPINoResult() {
        //given
        let location = "Abcbdbdbs"
        let promise = expectation(description: "No locations found")
        //when
        systemUnderTest.search(location: location) { (locations) in
            if locations.count == 0 {
                promise.fulfill()
            }
            else {
                XCTFail("Network Test -- Failed")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
