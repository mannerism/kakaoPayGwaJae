//
//  HomeViewController+ImageDetailViewControllerDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class HomeViewControllerImageDetailViewControllerDelegateUnitTest: XCTestCase {
	var sut: HomeViewController!
	
	override func setUp() {
		super.setUp()
		sut = HomeViewController()
		sut.viewDidLoad()
		sut.viewWillAppear(false)
		sut.api = MockRestProcessor()
	}
	
	func testDidDismiss() {
		let layout = UICollectionViewFlowLayout()
		let indexPath = IndexPath(item: 0, section: 0)
		let mock = MockCollectionView(
			frame: .zero,
			collectionViewLayout: layout)
		sut.viewDidLoad()
		sut.collectionView = mock
		sut.didDismiss(at: indexPath)
		XCTAssertNotNil(sut.api.requestDelegate)
		XCTAssertTrue(mock.didRun)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
