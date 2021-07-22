//
//  ImageDetailViewController+RestProcessorDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class ImageDetailViewControllerRestProcessorDelegateUnitTest: XCTestCase {
	
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
	}
	
	func testDidReceiveResponseFromDataTaskForSearch() {
		let imageProcessor = ImageDataProcessor()
		let response: Response = MockData.response
		let encoded = try? JSONEncoder().encode(response)
		let result = RestProcessor.Results(
			withData: encoded,
			response: nil,
			error: nil)
		let usage = RestUsage.Search(page: 0, searchText: "")
		sut.imageData = imageProcessor
		sut.didReceiveResponseFromDataTask(result, usage)
		XCTAssertTrue(sut.imageData.photos.count == 1)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
