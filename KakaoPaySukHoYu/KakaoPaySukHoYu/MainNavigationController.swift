//
//  MainNavigationController.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

class MainNavigationController: UINavigationController {
	
	// MARK: - Properties
	let customTabBarController = CustomTabBarController()
	
	// MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		viewControllers = [customTabBarController]
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	// MARK: - Handlers
	func setup() {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		view.backgroundColor = .clear
	}
}
