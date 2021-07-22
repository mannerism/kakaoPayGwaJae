//
//  HomeViewController.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/24.
//

import UIKit

class HomeViewController: UIViewController {
	
	// MARK: - Properties
	let homeCellId = "homeCellId"
	let homeHeaderId = "homeHeaderId"
	
	var api: RestProcessor!
	var imageData: ImageDataProcessor = ImageDataProcessor()
	var collectionView: UICollectionView!

	var fetchedPages = [Int]()
	var isFetching = false
	
	lazy var topGradientView: UIView = {
		let view = UIView(
			frame:
				CGRect(
					x: 0,
					y: 0,
					width: view.frame.width,
					height: 70.h
				)
		)
		let gradient = CAGradientLayer()
		gradient.frame = view.bounds
		gradient.colors = [
			UIColor.init(white: 0, alpha: 0.8).cgColor,
			UIColor.clear.cgColor
		]
		gradient.locations = [0.0, 0.75]
		view.layer.insertSublayer(gradient, at: 0)
		return view
	}()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	// MARK: - Init
	convenience init(_ api: RestProcessor) {
		self.init()
		self.api = api
		configureApi()
		getARandomPhoto()
		getPhotos()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		addViews()
		setConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnSwipe = true
	}
	
	// MARK: - Setup
	private func setup() {
		configureCollectionView()
	}
	
	private func addViews() {
		view.addSubviews(
			collectionView,
			topGradientView
		)
	}
	
	private func setConstraints() {
		collectionViewConstraints()
		topGradientViewConstraints()
	}
	
	private func configureApi() {
		api.requestDelegate = self
		api.reset()
		api.requestHttpHeaders.add(
			value: "application/json",
			forKey: "Content-Type")
		api.requestHttpHeaders.add(
			value: "Client-ID \(accessToken)",
			forKey: "Authorization")
	}
	
	private func configureCollectionView() {
		let layout = CustomHeaderLayout()
		layout.scrollDirection = .vertical
		collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = MNColor.darkGray
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(
			MainCell.self,
			forCellWithReuseIdentifier: homeCellId)
		collectionView.register(
			HomeHeader.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: homeHeaderId)
	}
	
	// MARK: - Handlers
	func getPhotos(page: Int = 1) {
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
	
	func getARandomPhoto() {
		guard let url = URL(
						string: EndPoint
							.singleRandom
							.description) else { return }
		api.makeRequest(
			toURL: url,
			withHttpMethod: .get,
			usage: .ARandomPhoto)
	}
	
	// MARK: - Constraints
	private func collectionViewConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	private func topGradientViewConstraints() {
		topGradientView.translatesAutoresizingMaskIntoConstraints = false
		topGradientView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		topGradientView.heightAnchor.constraint(equalToConstant: 100.h).isActive = true
		topGradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topGradientView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
}
