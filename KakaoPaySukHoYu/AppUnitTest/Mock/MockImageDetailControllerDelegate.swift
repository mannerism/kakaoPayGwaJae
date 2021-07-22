//
//  MockImageDetailControllerDelegate.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/07/01.
//

import UIKit
@testable import KakaoPaySukHoYu

class MockImageDetailControllerDelegate: ImageDetailControllerDelegate {
	var didRun: Bool = false
	
	func didDismiss(at indexPath: IndexPath?) {
		didRun = true
	}
}
