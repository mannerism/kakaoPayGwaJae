//
//  RestProcessorUnitTest.swift
//  RestProcessorUnitTest
//
//  Created by Yu Juno on 2021/06/29.
//

import XCTest
@testable import KakaoPaySukHoYu

class RestProcessorUnitTest: XCTestCase {
	var sut: RestProcessor!
	
	override func setUp() {
		super.setUp()
		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [MockURLSession.self]
		let urlSession = URLSession.init(configuration: configuration)
		sut = RestProcessor(urlSession)
	}
	
	func testMakeRequestSuccess() {
		/// Testing success case
		let requestDelegate = MockRequestDelegate()
		sut.requestDelegate = requestDelegate
		let apiURL = URL(string: EndPoint.photos.description)!
		let exp = expectation(description: "testMakeRequestSuccess")
		let jsonString = """
										 {
										 "id": "LBI7cgq3pbM",
										 "created_at": "2016-05-03T11:00:28-04:00",
										 "updated_at": "2016-07-10T11:00:01-05:00",
										 "width": 5245,
										 "height": 3497,
										 "color": "#60544D",
										 "blur_hash": "LoC%a7IoIVxZ_NM|M{s:%hRjWAo0",
										 }
										 """
		let data = jsonString.data(using: .utf8)
		
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == apiURL else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			let response = HTTPURLResponse(
				url: apiURL,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, data)
		}
		
		sut.makeRequest(
			toURL: apiURL,
			withHttpMethod: .get,
			usage: .Photos(page: 1)) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(requestDelegate.didRunSuccess)
		XCTAssertFalse(requestDelegate.didRunFailure)
	}
	
	func testMakeRequestFailure() {
		/// Testing .failedToCreateRequest case
		class MockSut: RestProcessor {
			override func prepareRequest(
				withURL url: URL?,
				httpBody: Data?,
				httpMethod: RestProcessor.HttpMethod
			) -> URLRequest? {
				return nil
			}
		}
		sut = MockSut()
		let requestDelegate = MockRequestDelegate()
		sut.requestDelegate = requestDelegate
		
		let apiURL = URL(string: EndPoint.photos.description)!
		let jsonString = """
										 {
										 "id": "LBI7cgq3pbM",
										 "created_at": "2016-05-03T11:00:28-04:00",
										 "updated_at": "2016-07-10T11:00:01-05:00",
										 "width": 5245,
										 "height": 3497,
										 "color": "#60544D",
										 "blur_hash": "LoC%a7IoIVxZ_NM|M{s:%hRjWAo0",
										 }
										 """
		let data = jsonString.data(using: .utf8)
		
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == apiURL else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			let response = HTTPURLResponse(
				url: apiURL,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, data)
		}
		
		let exp = expectation(description: "testMakeRequestSuccess")
		sut.makeRequest(
			toURL: apiURL,
			withHttpMethod: .get,
			usage: .Photos(page: 1)) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertFalse(requestDelegate.didRunSuccess)
		XCTAssertTrue(requestDelegate.didRunFailure)
	}
	
	func testAddingQueryParamsViaMakeRequest() {
		/// Testing success case
		let requestDelegate = MockRequestDelegate()
		sut.requestDelegate = requestDelegate
		let apiURL = URL(string: EndPoint.photos.description)!
		let exp = expectation(description: "testMakeRequestSuccess")
		let jsonString = """
										 {
										 "id": "LBI7cgq3pbM",
										 "created_at": "2016-05-03T11:00:28-04:00",
										 "updated_at": "2016-07-10T11:00:01-05:00",
										 "width": 5245,
										 "height": 3497,
										 "color": "#60544D",
										 "blur_hash": "LoC%a7IoIVxZ_NM|M{s:%hRjWAo0",
										 }
										 """
		let data = jsonString.data(using: .utf8)
		
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == URL(string: "https://api.unsplash.com/photos?page=1")! else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			
			let response = HTTPURLResponse(
				url: URL(string: "https://api.unsplash.com/photos?page=1")!,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, data)
		}
		
		sut.urlQueryParameters.add(
			value: "1",
			forKey: "page")
		
		sut.makeRequest(
			toURL: apiURL,
			withHttpMethod: .get,
			usage: .Photos(page: 1)) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(requestDelegate.didRunSuccess)
		XCTAssertFalse(requestDelegate.didRunFailure)
	}
	
	
	func testGetImageSuccess() {
		let apiURL = URL(string: EndPoint.photos.description)!
		let bundle = Bundle(for: RestProcessorUnitTest.self)
		let image: UIImage? = UIImage(
			named: "apitestimage",
			in: bundle,
			compatibleWith: nil)
		let imageData = image?.pngData()
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == apiURL else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			let response = HTTPURLResponse(
				url: apiURL,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, imageData)
		}
		
		let exp = expectation(description: "testGetImageSuccess")
		
		_ = sut.getImage(apiURL) { result in
			switch result {
			case .failure:
				XCTFail("Failure is not expected")
			case .success(let image):
				XCTAssertTrue(image.pngData()!.count > 0)
			}
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
	}
	
	func testGetImageFailure() {
		let apiURL = URL(string: EndPoint.photos.description)!
		let bundle = Bundle(for: RestProcessorUnitTest.self)
		let image: UIImage? = UIImage(
			named: "apitestimage",
			in: bundle,
			compatibleWith: nil)
		let imageData = image?.pngData()
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == apiURL else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			let response = HTTPURLResponse(
				url: apiURL,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, imageData)
		}
		
		let exp = expectation(description: "testGetImageFailure")
		
		_ = sut.getImage(URL(string: "wrongURL")!) { result in
			switch result {
			case .failure(let error):
				XCTAssertNotNil(error)
			case .success(_):
				XCTFail("Success is not expected")
			}
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
	}
	
	func testGetImageFromCache() {
		/// Step 1: get image and save to cache
		let apiURL = URL(string: EndPoint.photos.description)!
		let bundle = Bundle(for: RestProcessorUnitTest.self)
		let image: UIImage? = UIImage(
			named: "apitestimage",
			in: bundle,
			compatibleWith: nil)
		let imageData = image?.pngData()
		MockURLSession.requestHandler = { request in
			guard let url = request.url,
						url == apiURL else {
				throw RestProcessor.CustomError.failedToCreateRequest
			}
			let response = HTTPURLResponse(
				url: apiURL,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil)!
			return (response, imageData)
		}
		
		let exp = expectation(description: "testGetImageSuccess")
		
		_ = sut.getImage(apiURL) { result in
			switch result {
			case .failure:
				XCTFail("Failure is not expected")
			case .success(let image):
				XCTAssertTrue(image.pngData()!.count > 0)
			}
			exp.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		
		/// Step 2. Retrieve image from cache
		let exp2 = expectation(description: "testGetImageSuccess2")

		let result = sut.getImage(apiURL) { result in
			switch result {
			case .failure:
				XCTFail("Failure is not expected")
			case .success(let image):
				XCTAssertTrue(image.pngData()!.count > 0)
			}
			exp2.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNil(result)
	}
	
	func testReset() {
		let jsonString = """
										 {
										 "id": "LBI7cgq3pbM",
										 "created_at": "2016-05-03T11:00:28-04:00",
										 "updated_at": "2016-07-10T11:00:01-05:00",
										 "width": 5245,
										 "height": 3497,
										 "color": "#60544D",
										 "blur_hash": "LoC%a7IoIVxZ_NM|M{s:%hRjWAo0",
										 }
										 """
		let data = jsonString.data(using: .utf8)
		sut.httpBody = data
		sut.reset()
		XCTAssertNil(sut.httpBody)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
