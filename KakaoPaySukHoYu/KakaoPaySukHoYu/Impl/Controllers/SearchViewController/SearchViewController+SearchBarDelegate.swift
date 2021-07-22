//
//  SearchViewController+SearchBarDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.searchTextField.text else { return }
		view.endEditing(true)
		searchImageData.removeSearchVariables()
		fetchedPages.removeAll()
		searchPhotos(text)
	}
}
