//
//  UtilitiesUnitTest.swift
//  UtilitiesUnitTest
//
//  Created by Yu Juno on 2021/07/01.
//
import XCTest
@testable import KakaoPaySukHoYu

class ArrayExtensionUnitTest: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	func testSafeArray() {
		let emptyArray: [String] = []
		XCTAssertNil(emptyArray[safe:0])
	}
	
	override func tearDown() {
		super.tearDown()
	}
}
