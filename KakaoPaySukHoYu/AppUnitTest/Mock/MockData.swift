//
//  MockData.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/28.
//

import Foundation
@testable import KakaoPaySukHoYu

class MockData {
	static var response = Response(
		total: 10,
		totalPages: 10,
		photos: [MockData.photo] )
	static var photo = Photo(
		id: "testId",
		width: 10.0,
		height: 10.0,
		colorCode: "testColorCode",
		blurHash: "testBlurHash",
		description: "testDescription",
		urls: urls,
		sponsorship: sponsorship,
		user: user)
	static var user = User(name: "testName")
	static var sponsorship = Sponsorship(tagline: "testTagline")
	static var urls = Urls(small: "testSmallURL", regular: "testRegularURL")

}
