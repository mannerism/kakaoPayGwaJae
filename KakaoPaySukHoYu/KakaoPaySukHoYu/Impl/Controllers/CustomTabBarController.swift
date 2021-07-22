//
//  CustomTabBarController.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
	// MARK: - Properties
	var homeViewController: HomeViewController!
	var searchViewController: SearchViewController!
	var addViewController: UIViewController!
	var userViewController: UIViewController!
	
	// MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setUpTabBarAppearance()
	}
	
	// MARK: - Handlers
	private func setup() {
		configureMainViewController()
		configureSearchViewController()
		configurePlaceholderViewControllers()
		configureNavigationTitle()
		setViewControllers(
			[
				homeViewController,
				searchViewController,
				addViewController,
				userViewController
			],
			animated: true
		)
	}
	
	private func setUpTabBarAppearance() {
		tabBar.isTranslucent = true
		tabBar.barTintColor = .black
	}
	
	private func configureMainViewController() {
		let mainImage = UIImage(named: "homeicon")
		let barItem = UITabBarItem(title: nil, image: mainImage, tag: 0)
		barItem.imageInsets = tabBarImageInset
		barItem.selectedImage = mainImage?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
		homeViewController = HomeViewController(RestProcessor())
		homeViewController.tabBarItem = barItem
	}
	
	private func configureSearchViewController() {
		let mainImage = UIImage(named: "searchicon")
		let barItem = UITabBarItem(title: nil, image: mainImage, tag: 1)
		barItem.imageInsets = tabBarImageInset
		barItem.selectedImage = mainImage?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
		searchViewController = SearchViewController()
		searchViewController.tabBarItem = barItem
	}
	
	private func configurePlaceholderViewControllers() {
		let addImage = UIImage(named: "addicon")
		let userImage = UIImage(named: "usericon")
		let addBarItem = UITabBarItem(title: nil, image: addImage, tag: 2)
		let userBarItem = UITabBarItem(title: nil, image: userImage, tag: 3)
		addBarItem.selectedImage = addImage?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
		userBarItem.selectedImage = userImage?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
		addBarItem.imageInsets = tabBarImageInset
		userBarItem.imageInsets = tabBarImageInset
		addViewController = UIViewController()
		addViewController.view.backgroundColor = MNColor.darkGray
		addViewController.tabBarItem = addBarItem
		userViewController = UIViewController()
		userViewController.view.backgroundColor = MNColor.darkGray
		userViewController.tabBarItem = userBarItem
	}
	
	private func configureNavigationTitle() {
		let navLabel = UILabel()
		let navTitle = NSMutableAttributedString(
			string: "BLACK",
			attributes:[
				NSAttributedString.Key.foregroundColor: UIColor.white,
				NSAttributedString.Key.font: MNFont.bold(fontSize: 17).font!
			]
		)
		navTitle.append(
			NSMutableAttributedString(
				string: "MIRROR",
				attributes:[
					NSAttributedString.Key.font: MNFont.light(fontSize: 17).font!,
					NSAttributedString.Key.foregroundColor: UIColor.white
				]
			)
		)
		navLabel.attributedText = navTitle
		self.navigationItem.titleView = navLabel
	}
}
