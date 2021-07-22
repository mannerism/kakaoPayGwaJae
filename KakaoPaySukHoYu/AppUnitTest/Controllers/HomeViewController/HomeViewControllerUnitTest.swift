//
//  HomeViewControllerUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class HomeViewControllerUnitTest: XCTestCase {
	var sut: HomeViewController!
	
	override func setUp() {
		super.setUp()
		sut = HomeViewController()
		sut.viewDidLoad()
		sut.viewWillAppear(false)
		sut.api = MockRestProcessor()
	}
	
	func testInit() {
		XCTAssertTrue(sut.view.subviews.contains(sut.collectionView))
		XCTAssertTrue(sut.view.subviews.contains(sut.topGradientView))
		XCTAssertTrue(sut.preferredStatusBarStyle == .lightContent)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
