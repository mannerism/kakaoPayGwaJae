//
//  ImageDetailViewController+CollectionViewDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//

import UIKit

extension ImageDetailController:
	UICollectionViewDelegateFlowLayout,
	UICollectionViewDataSource,
	UICollectionViewDelegate {
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return imageData.photos.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
						withReuseIdentifier: imageDetailCellId,
						for: indexPath) as? ImageDetailCell else { return UICollectionViewCell() }
		let photoData = imageData.photos[indexPath.item]
		
		guard let urlString = photoData.urls.regular,
					let url = URL(string: urlString) else { return cell }
		
		let token = api.getImage(url) { result in
			let image = try? result.get()
			
			DispatchQueue.main.async {
				cell.imageView.image = image
			}
		}
		
		cell.onReuse = { [weak self] in
			if let token = token {
				self?.api.cancelLoad(token)
			}
		}
		
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(
			width: collectionView.frame.width,
			height: collectionView.frame.height - 150.h)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		setTabBarText(indexPath)
		
		if (imageData.photos.count - 4) < indexPath.item {
			getMorePhotos()
		}
		
		if !didRunOnce {
			startFromSelectedIndexPath()
		}
	}
	
	// MARK: - Helpers
	private func setTabBarText(_ indexPath: IndexPath) {
		tabBar.nameLabel.text = imageData.photos[indexPath.item].user.name
		tabBar.sponsorLabel.text = (imageData.photos[indexPath.item].sponsorship != nil)
			? "Sponsored"
			: nil
	}
	
	private func getMorePhotos() {
		let nextPage = imageData.getCurrentPage() + 1
		switch usage {
		case .photos:
			getPhotos(page: nextPage)
		case .search:
			searchPhotos(page: nextPage)
		default:
			break
		}
	}
	
	private func startFromSelectedIndexPath() {
		let indexToScrollTo: IndexPath = self.indexPath
		self.collectionView.scrollToItem(
			at: indexToScrollTo,
			at: .centeredHorizontally,
			animated: false)
		didRunOnce = true
	}
}
