//
//  SearchViewController+ImageDetailViewControllerDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//

import Foundation

extension SearchViewController: ImageDetailControllerDelegate {
	func didDismiss(at indexPath: IndexPath?) {
		api.requestDelegate = self
		collectionView.reloadData()
		guard let indexPath = indexPath else { return }
		collectionView.scrollToItem(
			at: indexPath,
			at: .centeredVertically,
			animated: false)
	}
}
