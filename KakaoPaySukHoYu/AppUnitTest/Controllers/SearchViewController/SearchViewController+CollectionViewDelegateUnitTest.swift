//
//  SearchViewController+CollectionViewDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class SearchViewControllerCollectionViewDelegateUnitTest: XCTestCase {
	var sut: SearchViewController!
	let indexPath = IndexPath(item: 0, section: 0)
	
	override func setUp() {
		super.setUp()
		sut = SearchViewController()
		sut.viewDidLoad()
		sut.api = MockRestProcessor()
		sut.searchImageData = ImageDataProcessor()
	}
	
	// MARK: - SearchViewController+CollectionViewDelegate
	func testNumberOfItemsInSection() {
		sut.searchImageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		let  result = sut.collectionView.numberOfItems(inSection: 0)
		XCTAssertTrue(result == 3)
	}
	
	func testDidSelectItemAt() {
		let mockNavigationController = MockNavigationController(rootViewController: sut)
		UIApplication.shared.windows
			.filter {$0.isKeyWindow}
			.first?.rootViewController = mockNavigationController
		sut.searchImageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		sut.collectionView.reloadData()

		sut.collectionView(
			sut.collectionView,
			didSelectItemAt: indexPath)
		XCTAssertTrue(mockNavigationController.pushedViewController is ImageDetailController)
	}
	
	func testCellForItemAt() {
		let exp = expectation(description: "testCellForItemAt")
		sut.searchImageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		let cell = sut.collectionView(
			sut.collectionView,
			cellForItemAt: indexPath) as! MainCell
		DispatchQueue.main.async {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNotNil(cell.imageView.image)
	}
	
	func testSizeForItemAtWithImages() {
		sut.searchImageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		let size = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			sizeForItemAt: indexPath)
		XCTAssertTrue(size.width == 0.0)
		XCTAssertTrue(size.height == 0.0)
	}
	
	func testSizeForItemAtWithoutImage() {
		let size = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			sizeForItemAt: indexPath)
		XCTAssertTrue(size.width == 0.0)
		XCTAssertTrue(size.height == 250.h)
	}
	
	func testMinimumLineSpacingForSectionAt() {
		let line = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			minimumLineSpacingForSectionAt: 0)
		XCTAssertTrue(line == 1.h)
	}
	
	func testMinimumInterItemSpacing() {
		let space = sut.collectionView(
			sut.collectionView,
		 layout: UICollectionViewFlowLayout(),
			minimumInteritemSpacingForSectionAt: 0)
		XCTAssertTrue(space == 0)
	}
	
	func testScrollViewDidScroll() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let scrollView = UIScrollView(frame: frame)
		let mockAPI = MockRestProcessor()
		scrollView.contentOffset.y = 60
		
		sut.searchImageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		sut.searchImageData.setSearchText("testSearch")
		sut.api = mockAPI
		sut.scrollViewDidScroll(scrollView)
		XCTAssertTrue(mockAPI.didRunMakeRequest)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
