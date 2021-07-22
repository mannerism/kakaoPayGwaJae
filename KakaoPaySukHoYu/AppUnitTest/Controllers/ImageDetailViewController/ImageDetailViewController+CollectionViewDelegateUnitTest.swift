//
//  ImageDetailViewController+CollectionViewDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class ImageDetailViewControllerCollectionViewDelegateUnitTest: XCTestCase {
	
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
	
	func testNumberOfItemsInSection() {
		sut.imageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		let result = sut.collectionView(
			sut.collectionView,
			numberOfItemsInSection: 0)
		XCTAssertTrue(result == 3)
	}
	
	func testCellForItemAt() {
		let exp = expectation(description: "testCellForItemAt")
		sut.imageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		let cell = sut.collectionView(
			sut.collectionView,
			cellForItemAt: indexPath) as? ImageDetailCell
		DispatchQueue.main.async {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNotNil(cell?.imageView.image)
	}
	
	func testSizeForItemAt() {
		let size = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			sizeForItemAt: indexPath)
		XCTAssertTrue(size.width == 0)
		XCTAssertTrue(size.height < 0)
	}
	
	func testMinimumLineSpacingForSectionAt() {
		let line = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			minimumLineSpacingForSectionAt: 0)
		XCTAssertTrue(line == 0)
	}
	
	func testMinimumInterItemSpacing() {
		let space = sut.collectionView(
			sut.collectionView,
		 layout: UICollectionViewFlowLayout(),
			minimumInteritemSpacingForSectionAt: 0)
		XCTAssertTrue(space == 0)
	}
	
	func testWillDisplayPhotos() {
		let mockApi = MockRestProcessor()
		sut.api = mockApi
		sut.imageData.addPhotos([MockData.photo])
		sut.collectionView(
			sut.collectionView,
			willDisplay: ImageDetailCell(),
			forItemAt: indexPath)
		XCTAssertNotNil(sut.tabBar.nameLabel.text)
		XCTAssertTrue(mockApi.didRunMakeRequest)
	}
	
	func testWillDisplaySearch() {
		let mockApi = MockRestProcessor()
		sut.api = mockApi
		sut.imageData.addPhotos([MockData.photo])
		sut.imageData.searchText = "testSearch"
		sut.usage = .search
		sut.collectionView(
			sut.collectionView,
			willDisplay: ImageDetailCell(),
			forItemAt: indexPath)
		XCTAssertNotNil(sut.tabBar.nameLabel.text)
		XCTAssertTrue(mockApi.didRunMakeRequest)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
