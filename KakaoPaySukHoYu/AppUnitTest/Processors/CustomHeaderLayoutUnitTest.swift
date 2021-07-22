//
//  CustomHeaderLayoutUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/28.
//

import XCTest
@testable import KakaoPaySukHoYu

class AppDelegateUnitTests: XCTestCase {
	var sut: CustomHeaderLayout!
	let header = UICollectionReusableView()
	
	override func setUp() {
		super.setUp()
		sut = CustomHeaderLayout()
	}
	
	func testLayoutAttributesForElements() {
		let result = sut.layoutAttributesForElements(in: header.frame)
		XCTAssertTrue(result!.isEmpty)
	}
	
	func testShouldInvalidateLayout() {
		let result = sut.shouldInvalidateLayout(forBoundsChange: header.frame)
		XCTAssertTrue(result)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
