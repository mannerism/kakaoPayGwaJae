//
//  ImageDetailViewController+RestProcessorDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//

import Foundation

extension ImageDetailController: RestProcessorRequestDelegate {
	func didFailToPrepareRequest(
		_ result: RestProcessor.Results,
		_ usage: RestUsage
	) {
		// TODO: - should handle error here
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
		guard let data = result.data else { return }
		
		switch usage {
		case .Photos(page: _):
			guard let decoded = try? JSONDecoder().decode(
							[Photo].self,
							from: data) else { return }
			imageData.addPhotos(decoded)
		case .Search(page: _, searchText: _):
			guard let decoded = try? JSONDecoder().decode(
							Response.self,
							from: data) else { return }
			imageData.addPhotos(decoded.photos)
		default:
			break
		}

		DispatchQueue.main.async {
			self.collectionView.performBatchUpdates({
				let indexSet = IndexSet(integersIn: 0...0)
				self.collectionView.reloadSections(indexSet)
			}, completion: nil)
		}
	}
}
