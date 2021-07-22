//
//  MainNavigationControllerUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/28.
//

import XCTest
@testable import KakaoPaySukHoYu

class MainNavigationControllerUnitTest: XCTestCase {
	var sut: MainNavigationController!
	
	override func setUp() {
		super.setUp()
		sut = MainNavigationController()
	}
	
	func testInit() {
		XCTAssertTrue(sut.navigationBar.isTranslucent)
		XCTAssertTrue(sut.view.backgroundColor == .clear)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
