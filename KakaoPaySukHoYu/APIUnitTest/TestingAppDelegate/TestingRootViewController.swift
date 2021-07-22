//
//  TestingRootViewController.swift
//  APIUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit

class TestingRootViewController: UIViewController {
	
	override func loadView() {
		let label = UILabel()
		label.text = "Running Unit Tests..."
		label.textAlignment = .center
		label.textColor = .white
		view = label
	}
}
