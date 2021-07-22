//
//  HomeViewController+CollectionViewDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/26.
//

import UIKit

extension HomeViewController:
	UICollectionViewDelegate,
	UICollectionViewDelegateFlowLayout,
	UICollectionViewDataSource {
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		let vc = ImageDetailController(
			usage: .photos,
			imageData,
			api,
			indexPath)
		vc.delegate = self
		navigationController?.pushViewController(vc, animated: true)
	}
	
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
			withReuseIdentifier: homeCellId,
			for: indexPath
		) as? MainCell else { return UICollectionViewCell() }
		
		let photoData = imageData.photos[indexPath.item]
		cell.photoData = photoData
		
		guard let urlString = photoData.urls.small,
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
		guard let photo = imageData.photos[safe: indexPath.item] else {
			return CGSize(
				width: collectionView.frame.width,
				height: 250.h
			)
		}
		return photo.getCellSize(collectionView)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 1.h
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
	
	//MARK: - Header
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		
		guard let header = collectionView.dequeueReusableSupplementaryView(
						ofKind: UICollectionView.elementKindSectionHeader,
						withReuseIdentifier: homeHeaderId,
						for: indexPath) as? HomeHeader else { return UICollectionReusableView() }
					
		guard let headerPhoto = imageData.headerPhoto else { return header}
		
		header.photoData = headerPhoto
		guard let urlString = headerPhoto.urls.regular,
					let url = URL(string: urlString) else { return header }

		let token = api.getImage(url) { result in
			let image = try? result.get()
			DispatchQueue.main.async {
				header.imageView.image = image
			}
		}

		header.onReuse = { [weak self] in
			if let token = token {
				self?.api.cancelLoad(token)
			}
		}
		
		return header
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		guard let headerPhoto = imageData.headerPhoto else {
			return CGSize(
				width: collectionView.frame.width,
				height: 200.h
			)
		}
		return headerPhoto.getCellSize(collectionView)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		toggleTabBar(scrollView)
		fetchPhotosBasedOnScrollPosition(scrollView)
	}
	
	// MARK: - Helpers
	private func fetchPhotosBasedOnScrollPosition(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let scrollHeight = scrollView.frame.size.height
		if ( offsetY >= (contentHeight - scrollHeight) ) {
			let nextPage = imageData.getCurrentPage() + 1
			guard !fetchedPages.contains(nextPage),
						!isFetching else { return }
			isFetching = true
			getPhotos(page: nextPage)
		}
	}
	
	private func toggleTabBar(_ scrollView: UIScrollView) {
		if scrollView.panGestureRecognizer.translation(in: scrollView).y < -5.h{
			UIView.animate(withDuration: 0.3) {
				self.tabBarController?.tabBar.alpha = 0
			}
		} else{
			UIView.animate(withDuration: 0.5) {
				self.tabBarController?.tabBar.alpha = 1
			}
		}
	}
}
