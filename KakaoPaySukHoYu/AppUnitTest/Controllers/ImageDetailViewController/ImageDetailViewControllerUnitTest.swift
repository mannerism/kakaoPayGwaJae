//
//  ImageDetailViewControllerUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class ImageDetailViewControllerUnitTest: XCTestCase {
	
	var sut: ImageDetailController!
	let indexPath = IndexPath(item: 0, section: 0)
	
	override func setUp() {
		super.setUp()
		sut = ImageDetailController(
			usage: .photos,
			ImageDataProcessor(),
			MockRestProcessor(),
			indexPath)
	}
	
	func testInit() {
		XCTAssertTrue(sut.view.subviews.contains(sut.collectionView))
		XCTAssertTrue(sut.view.subviews.contains(sut.tabBar))
	}
	
	func testViewWillAppear() {
		let mockNav = MockNavigationController(rootViewController: sut)
		sut.viewWillAppear(false)
		XCTAssertTrue(mockNav.navigationBar.isHidden)
		XCTAssertFalse(mockNav.hidesBarsOnSwipe)
	}
	
	func testHandleBackButton() {
		let exp = expectation(description: "testHandleBackButton")
		let mockNav = MockNavigationController(rootViewController: UIViewController())
		mockNav.pushViewController(sut, animated: false)
		sut.handleBackButton()
		UIView.animate(withDuration: 1) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(mockNav.viewControllers.count == 1)
	}
	
	func testToggleTabBarDissappear() {
		let exp = expectation(description: "tab bar dissappears")

		sut.tabBar.alpha = 1
		sut.handleTabBarToggle()
		
		UIView.animate(withDuration: 1) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(sut.tabBar.alpha == 0)
	}
	
	func testToggleTabBarAppear() {
		let exp = expectation(description: "tab bar appears")

		sut.tabBar.alpha = 0
		sut.handleTabBarToggle()
		
		UIView.animate(withDuration: 1) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(sut.tabBar.alpha == 1)
	}
	
	func testGetPhotos() {
		let mockApi = MockRestProcessor()
		sut.api = mockApi
		sut.getPhotos(page: 1)
		XCTAssertTrue(mockApi.didRunMakeRequest)
	}
	
	func testSearchPhotos() {
		let mockApi = MockRestProcessor()
		let mockImage = ImageDataProcessor()
		mockImage.searchText = "testSearch"
		sut.imageData = mockImage
		sut.api = mockApi
		sut.searchPhotos(page: 1)
		XCTAssertTrue(mockApi.didRunMakeRequest)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
