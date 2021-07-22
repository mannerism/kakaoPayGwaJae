//
//  EndPointUnitTest.swift
//  APIUnitTest
//
//  Created by Yu Juno on 2021/06/29.
//

import XCTest
@testable import KakaoPaySukHoYu

class EndPointUnitTest: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	func testBaseUrlRaw() {
		XCTAssertTrue(baseURL == "https://api.unsplash.com/")
	}
	
	func testDescription() {
		XCTAssertTrue(EndPoint.photos.description == baseURL + "photos")
		XCTAssertTrue(EndPoint.singleRandom.description == baseURL + "photos/random")
		XCTAssertTrue(EndPoint.search.description == baseURL + "search/photos")
	}
	
	override func tearDown() {
		super.tearDown()
	}
}
