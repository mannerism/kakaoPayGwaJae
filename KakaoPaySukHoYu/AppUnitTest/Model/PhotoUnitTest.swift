//
//  PhotoUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/29.
//

import XCTest
@testable import KakaoPaySukHoYu

class PhotoUnitTest: XCTestCase {
	var sut: Photo! = MockData.photo
	
	override func setUp() {
		super.setUp()
	}
	
	func testGetCellSize() {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout)
		let result = sut.getCellSize(collectionView)
		XCTAssertTrue(result.width == 0.0)
		XCTAssertTrue(result.height == 0.0)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
