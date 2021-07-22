//
//  MockRestProcessor.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit
@testable import KakaoPaySukHoYu

class MockRestProcessor: RestProcessor {
	var didRunMakeRequest: Bool = false
	var didRunGetImage: Bool = false
	
	override func makeRequest(
		toURL url: URL,
		withHttpMethod httpMethod: RestProcessor.HttpMethod,
		usage: RestUsage,
		callBack: (() -> Void)? = nil
	) {
		didRunMakeRequest = true
		return
	}
	
	override func getImage(
		_ url: URL,
		_ completion: @escaping (Result<UIImage, Error>) -> Void
	) -> UUID? {
		didRunGetImage = true
		let bundle = Bundle(for: SearchViewControllerUnitTest.self)
		guard let image = UIImage(
						named: "apitestimage",
						in: bundle,
						compatibleWith: nil) else { return nil }
		completion(.success(image))
		return nil
	}
}
