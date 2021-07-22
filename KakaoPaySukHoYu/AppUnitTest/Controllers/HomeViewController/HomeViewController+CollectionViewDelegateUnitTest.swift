//
//  HomeViewController+CollectionViewDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class HomeViewControllerCollectionViewDelegateUnitTest: XCTestCase {
	var sut: HomeViewController!
	let indexPath = IndexPath(item: 0, section: 0)
	
	override func setUp() {
		super.setUp()
		sut = HomeViewController(MockRestProcessor())
		sut.viewDidLoad()
		sut.imageData = ImageDataProcessor()
	}
	
	func testDidSelectItem() {
		let mockNavigationController = MockNavigationController(rootViewController: sut)
		UIApplication.shared.windows
			.filter {$0.isKeyWindow}
			.first?.rootViewController = mockNavigationController
		sut.imageData.addPhotos(
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
	
	func testNumberOfItemsInSection() {
		sut.imageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		
		let count = sut.collectionView(
			sut.collectionView,
			numberOfItemsInSection: 0)
		XCTAssertTrue(count == 3)
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
			cellForItemAt: indexPath) as! MainCell
		DispatchQueue.main.async {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNotNil(cell.imageView.image)
	}
	
	func testSizeForItemAtWithImages() {
		sut.imageData.addPhotos(
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
	
	func testViewForSupplementaryElementOfKind() {
		class MockCV: UICollectionView {
			override func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
				return HomeHeader()
			}
		}
		sut.collectionView = MockCV(
			frame: .zero,
			collectionViewLayout: UICollectionViewFlowLayout())
		let exp = expectation(description: "testViewForSupplementaryElementOfKind")
		sut.imageData.headerPhoto = MockData.photo
		sut.collectionView.collectionViewLayout.invalidateLayout()
		let header = sut.collectionView(
			sut.collectionView,
			viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
			at: indexPath) as? HomeHeader
		DispatchQueue.main.async {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNotNil(header?.imageView.image)
	}
	
	func testReferenceSizeForHeaderInSectionWithImage() {
		sut.imageData.headerPhoto = MockData.photo
		let size = sut.collectionView(
			sut.collectionView, layout: UICollectionViewFlowLayout(),
			referenceSizeForHeaderInSection: 0)
		print(size)
		XCTAssertTrue(size.width == 0.0)
		XCTAssertTrue(size.height == 0.0)
	}
	
	func testReferenceSizeForHeaderInSectionWithoutImage() {
		let size = sut.collectionView(
			sut.collectionView,
			layout: UICollectionViewFlowLayout(),
			referenceSizeForHeaderInSection: 0)
		XCTAssertTrue(size.width == 0.0)
		XCTAssertTrue(size.height == 200.h)
	}

	func testScrollViewDidScrollDown() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let scrollView = UIScrollView(frame: frame)
		let mockAPI = MockRestProcessor()
		scrollView.contentOffset.y = 60
		sut.imageData.addPhotos(
			[
				MockData.photo,
				MockData.photo,
				MockData.photo
			])
		sut.api = mockAPI
		sut.scrollViewDidScroll(scrollView)
		XCTAssertTrue(mockAPI.didRunMakeRequest)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
