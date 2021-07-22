//
//  SearchViewController.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

class SearchViewController: UIViewController {
	
	// MARK: - Properties
	let searchCellId = "searchCellId"
	
	var api: RestProcessor!
	var searchImageData: ImageDataProcessor = ImageDataProcessor()
	var collectionView: UICollectionView!

	var fetchedPages = [Int]()
	var isFetching = false
	
	let searchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.image(for: .search, state: .normal)?.withTintColor(.white)
		sb.barTintColor = MNColor.darkGray
		sb.backgroundColor = MNColor.darkGray
		sb.searchTextField.placeholder = "Search Photos"
		sb.searchTextField.textColor = .white
		sb.searchTextField.backgroundColor = .darkGray
		return sb
	}()
	
	// MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		addViews()
		setConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureNavigationBar()
	}
	
	// MARK: - Setup
	private func setup() {
		view.backgroundColor = MNColor.darkGray
		searchBar.delegate = self
		configureApi()
		configureCollectionView()
	}
	
	private func addViews() {
		view.addSubviews(
			searchBar,
			collectionView)
	}
	
	private func setConstraints() {
		searchBarConstraints()
		collectionViewConstraints()
	}
	
	private func configureNavigationBar() {
		navigationController?.setNavigationBarHidden(true, animated: false)
		navigationController?.hidesBarsOnSwipe = false
	}
	
	private func configureApi() {
		api = RestProcessor()
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
		let layout = UICollectionViewFlowLayout()
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
			forCellWithReuseIdentifier: searchCellId)
	}
	
	// MARK: - Handlers
	func searchPhotos(
		_ text: String,
		_ page: Int = 1
	) {
		guard let url = URL(
						string: EndPoint
							.search
							.description) else { return }
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
	private func searchBarConstraints() {
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		searchBar.heightAnchor.constraint(equalToConstant: 35.h).isActive = true
		searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.h).isActive = true
	}
	
	private func collectionViewConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10.h).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}
