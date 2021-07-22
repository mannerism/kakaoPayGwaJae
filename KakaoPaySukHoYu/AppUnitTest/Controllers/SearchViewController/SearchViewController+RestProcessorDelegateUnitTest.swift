//
//  SearchViewController+RestProcessorDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class SearchViewControllerRestProcessorDelegateUnitTest: XCTestCase {
	var sut: SearchViewController!
	
	override func setUp() {
		super.setUp()
		sut = SearchViewController()
		sut.viewDidLoad()
		sut.api = MockRestProcessor()
		sut.searchImageData = ImageDataProcessor()
	}
	
	// MARK: - SearchViewController+RestProcessorDelegate
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
	
	func testDidReceiveResponseFromDataTask() {
		let imageProcessor = ImageDataProcessor()
		let response: Response = MockData.response
		let encoded = try? JSONEncoder().encode(response)
		let result = RestProcessor.Results(
			withData: encoded,
			response: nil,
			error: nil)
		let usage = RestUsage.Search(
			page: 0,
			searchText: "testSearch")
		sut.searchImageData = imageProcessor
		sut.didReceiveResponseFromDataTask(result, usage)
		XCTAssertTrue(imageProcessor.searchText == "testSearch")
	}

	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
