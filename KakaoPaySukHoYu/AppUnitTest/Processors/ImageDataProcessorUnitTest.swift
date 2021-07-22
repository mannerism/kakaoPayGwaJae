//
//  ImageDataProcessorUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/28.
//

import XCTest
@testable import KakaoPaySukHoYu

class ImageDataProcessorUnitTest: XCTestCase {
	var sut: ImageDataProcessor!
	
	override func setUp() {
		super.setUp()
		sut = ImageDataProcessor()
	}
	
	func testAddPhotos() {
		 sut.addPhotos([MockData.photo])
		XCTAssertTrue(sut.photos.count == 1)
	}
	
	func testSetHeaderPhoto() {
		sut.setHeaderPhoto(MockData.photo)
		XCTAssertNotNil(sut.headerPhoto)
	}
	
	func testRemoveAll() {
		sut.addPhotos([MockData.photo])
		sut.setHeaderPhoto(MockData.photo)
		sut.removeSearchVariables()
		XCTAssertTrue(sut.photos.count == 0)
		XCTAssertNil(sut.searchText)
	}
	
	func testGetCurrentPage() {
		sut.photos = [Photo](
			repeating: MockData.photo,
			count: 9)
		let result = sut.getCurrentPage()
		XCTAssertTrue(result == 1)
		
		sut.photos = [Photo](
			repeating: MockData.photo,
			count: 12)
		let result2 = sut.getCurrentPage()
		XCTAssertTrue(result2 == 2)
		
		sut.photos = [Photo](
			repeating: MockData.photo,
			count: 33)
		let result3 = sut.getCurrentPage()
		XCTAssertTrue(result3 == 4)
		
		sut.photos = [Photo](
			repeating: MockData.photo,
			count: 10)
		let result4 = sut.getCurrentPage()
		XCTAssertTrue(result4 == 1)
		
		sut.photos = [Photo](
			repeating: MockData.photo,
			count: 20)
		let result5 = sut.getCurrentPage()
		XCTAssertTrue(result5 == 2)
	}
	
	func testSetSearchText() {
		sut.setSearchText("test")
		XCTAssertTrue(sut.searchText == "test")
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
