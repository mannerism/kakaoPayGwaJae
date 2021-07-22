//
//  ImageDetailViewController.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/27.
//

import UIKit

protocol ImageDetailControllerDelegate: AnyObject {
	func didDismiss(at indexPath: IndexPath?)
}

class ImageDetailController: UIViewController {
	// MARK: - Properties
	let imageDetailCellId = "imageDetailCellId"
	
	var imageData: ImageDataProcessor!
	var api: RestProcessor!
	var indexPath: IndexPath!
	var collectionView: UICollectionView!
	var usage: EndPoint!
	var tabBar: ImageDetailTabBar!
	var tapGesture: UITapGestureRecognizer!
	
	var didRunOnce = false

	weak var delegate: ImageDetailControllerDelegate?
	
	convenience init(
		usage: EndPoint,
		_ imageData: ImageDataProcessor,
		_ api: RestProcessor,
		_ indexPath: IndexPath
	) {
		self.init()
		self.usage = usage
		self.imageData = imageData
		self.api = api
		self.api.requestDelegate = self
		self.indexPath = indexPath
		setup()
		addViews()
		setConstraints()
	}
	
	// MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureNavigationBar()
		configureCollectionViewPosition()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if self.isMovingFromParent {
			let indexPath = collectionView.indexPathsForVisibleItems.first
			delegate?.didDismiss(at: indexPath)
		}
	}
	
	// MARK: - Setup
	private func setup() {
		configureCollectionView()
		configureTabBar()
		configureTapGesture()
	}
	
	private func configureCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.register(
			ImageDetailCell.self,
			forCellWithReuseIdentifier: imageDetailCellId)
	}
	
	private func configureNavigationBar() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.hidesBarsOnSwipe = false
	}
	
	private func configureCollectionViewPosition() {
		collectionView.layoutIfNeeded()
	}
	
	private func configureTabBar() {
		tabBar = ImageDetailTabBar()
		tabBar.backButton.addTarget(
			self,
			action: #selector(handleBackButton),
			for: .touchUpInside)
	}
	
	private func configureTapGesture() {
		tapGesture = UITapGestureRecognizer(
			target: self,
			action: #selector(handleTabBarToggle))
		tapGesture.delegate = self
		view.addGestureRecognizer(tapGesture)
	}
	
	private func addViews() {
		view.addSubviews(
			collectionView,
			tabBar
		)
	}
	
	private func setConstraints() {
		collectionViewConstraints()
		tabBarConstraints()
	}
	
	// MARK: - Handlers
	@objc func handleTabBarToggle() {
		tabBar.toggleTabBar()
	}
	
	@objc func handleBackButton() {
		navigationController?.popViewController(animated: true)
	}
	
	func getPhotos(page: Int ) {
		guard let url = URL(
						string: EndPoint
							.photos
							.description) else { return }
		api.urlQueryParameters.add(
			value: "\(page)",
			forKey: "page")
		api.makeRequest(
			toURL: url,
			withHttpMethod: .get,
			usage: .Photos(page: page))
	}
	
	func searchPhotos(page: Int) {
		guard let url = URL(
						string: EndPoint
							.search
							.description),
					let text = imageData.searchText else { return }
		api.urlQueryParameters.add(
			value: "\(page)",
			forKey: "page")
		api.urlQueryParameters.add(
			value: text,
			forKey: "query")
		api.makeRequest(
			toURL: url,
			withHttpMethod: .get,
			usage: .Search(
				page: page,
				searchText: text) )
	}
	
	// MARK: - Constraints
	private func collectionViewConstraints() {
		collectionView.anchor(
			top: view.topAnchor,
			leading: view.leadingAnchor,
			bottom: view.bottomAnchor,
			trailing: view.trailingAnchor)
	}
	
	private func tabBarConstraints() {
		tabBar.translatesAutoresizingMaskIntoConstraints = false
		tabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		tabBar.heightAnchor.constraint(equalToConstant: 120.h).isActive = true
		tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
}

extension ImageDetailController: UIGestureRecognizerDelegate {
	func gestureRecognizer(
		_ gestureRecognizer: UIGestureRecognizer,
		shouldReceive touch: UITouch
	) -> Bool {
		return !(touch.view?.isDescendant(of: tabBar) == true)
	}
}
