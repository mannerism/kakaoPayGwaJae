//
//  MockRequestDelegate.swift
//  APIUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import Foundation
@testable import KakaoPaySukHoYu

class MockRequestDelegate: RestProcessorRequestDelegate {
	var didRunSuccess: Bool = false
	var didRunFailure: Bool = false
	
	func didFailToPrepareRequest(
		_ result: RestProcessor.Results,
		_ usage: RestUsage) {
		didRunFailure = true
	}
	
	func didReceiveResponseFromDataTask(
		_ result: RestProcessor.Results,
		_ usage: RestUsage) {
		didRunSuccess = true
	}
}
