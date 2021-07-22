//
//  MockNavigationController.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit
class MockNavigationController: UINavigationController {
	
	var pushedViewController: UIViewController?
	var didPopViewController: Bool = false
	
	override func pushViewController(
		_ viewController: UIViewController,
		animated: Bool
	) {
		pushedViewController = viewController
		super.pushViewController(viewController, animated: false)
	}
	
	override func popViewController(animated: Bool) -> UIViewController? {
		didPopViewController = true
		super.popViewController(animated: false)
		return nil
	}
}
