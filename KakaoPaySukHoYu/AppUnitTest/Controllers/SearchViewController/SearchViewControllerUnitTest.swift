//
//  SearchViewControllerUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class SearchViewControllerUnitTest: XCTestCase {
	var sut: SearchViewController!
	
	override func setUp() {
		super.setUp()
		sut = SearchViewController()
		sut.api = MockRestProcessor()
	}
	
	func testInit() {
		sut.viewDidLoad()
		XCTAssertTrue(sut.view.subviews.contains(sut.searchBar))
		XCTAssertTrue(sut.view.subviews.contains(sut.collectionView))
		XCTAssertTrue(sut.view.backgroundColor == MNColor.darkGray)
	}
	
	func testViewWillAppear() {
		let mockNav = MockNavigationController(rootViewController: sut)
		sut.viewWillAppear(false)
		XCTAssertTrue(mockNav.navigationBar.isHidden)
		XCTAssertFalse(mockNav.hidesBarsOnSwipe)
	}
	
	func testSearchPhoto() {
		let mock = MockRestProcessor()
		sut.api = mock
		sut.searchPhotos("")
		XCTAssertTrue(mock.didRunMakeRequest)
		XCTAssertFalse(mock.didRunGetImage)
	}

	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
