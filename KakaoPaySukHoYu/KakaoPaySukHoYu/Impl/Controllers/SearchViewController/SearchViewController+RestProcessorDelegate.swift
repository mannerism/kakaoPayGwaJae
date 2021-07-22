//
//  SearchViewController+RestProcessorDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//

import Foundation

extension SearchViewController: RestProcessorRequestDelegate {
	func didFailToPrepareRequest(
		_ result: RestProcessor.Results,
		_ usage: RestUsage
	) {
		// TODO: - should handle error here
		switch usage {
		case .ARandomPhoto:
			print("Failed to fetch a random photo")
		case .Photos(page: let page):
			print("Failed to fetch photos at page \(page)")
		case .Search(page: let page, searchText: let text):
			print("Failed to search \(text) at page \(page)")
		}
	}
	
	func didReceiveResponseFromDataTask(
		_ result: RestProcessor.Results,
		_ usage: RestUsage
	) {
		isFetching = false
		guard let data = result.data else { return }
		if case let RestUsage.Search(
				page: page,
				searchText: text
		) = usage {
			guard let decoded = try? JSONDecoder().decode(
							Response.self,
							from: data) else { return }
			searchImageData.setSearchText(text)
			searchImageData.addPhotos(decoded.photos)
			fetchedPages.append(page)
		}
		DispatchQueue.main.async {
			self.collectionView.performBatchUpdates({
				let indexSet = IndexSet(integersIn: 0...0)
				self.collectionView.reloadSections(indexSet)
			}, completion: nil)
		}
	}
}
