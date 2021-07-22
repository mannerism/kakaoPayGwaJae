//
//  HomeViewController+RestProcessorDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class HomeViewControllerRestProcessorDelegateUnitTest: XCTestCase {
	var sut: HomeViewController!
	
	override func setUp() {
		super.setUp()
		sut = HomeViewController()
		sut.viewDidLoad()
		sut.viewWillAppear(false)
		sut.api = MockRestProcessor()
	}
	
	func testDidFailToPrepareRequest() {
		let error = RestProcessor.CustomError.failedToCreateRequest
		sut.didFailToPrepareRequest(
			.init(withError: error),
			.ARandomPhoto)
		sut.didFailToPrepareRequest(
			.init(withError: error),
			.Photos(page: 0))
		sut.didFailToPrepareRequest(
			.init(withError: error),
			.Search(page: 0, searchText: "testSearch") )
		/// Nothing to check as of now, more functionality check later when pop up or message feature is added
	}
	
	func testDidReceiveResponseFromDataTaskForPhotos() {
		let imageProcessor = ImageDataProcessor()
		let response: [Photo] = [MockData.photo]
		let encoded = try? JSONEncoder().encode(response)
		let result = RestProcessor.Results(
			withData: encoded,
			response: nil,
			error: nil)
		let usage = RestUsage.Photos(page: 1)
		sut.imageData = imageProcessor
		sut.didReceiveResponseFromDataTask(result, usage)
		XCTAssertTrue(sut.imageData.photos.count == 1)
		XCTAssertTrue(sut.fetchedPages.last == 1)
	}
	
	func testDidReceiveResponseFromDataTaskForARandomPhoto() {
		let imageProcessor = ImageDataProcessor()
		let response: Photo = MockData.photo
		let encoded = try? JSONEncoder().encode(response)
		let result = RestProcessor.Results(
			withData: encoded,
			response: nil,
			error: nil)
		let usage = RestUsage.ARandomPhoto
		sut.imageData = imageProcessor
		sut.didReceiveResponseFromDataTask(result, usage)
		XCTAssertNotNil(sut.imageData.headerPhoto)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
