//
//  SearchViewController+CollectionViewDelegate.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//
import UIKit

extension SearchViewController:
	UICollectionViewDelegate,
	UICollectionViewDelegateFlowLayout,
	UICollectionViewDataSource {
	
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return searchImageData.photos.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		let vc = ImageDetailController(
			usage: .search,
			searchImageData,
			api,
			indexPath)
		vc.delegate = self
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: searchCellId,
			for: indexPath
		) as? MainCell else { return UICollectionViewCell() }
		
		let photoData = searchImageData.photos[indexPath.item]
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
		guard let photo = searchImageData.photos[safe: indexPath.item] else {
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
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		view.endEditing(true)
		fetchPhotosBasedOnScrollPosition(scrollView)
	}
	
	// MARK: - Helpers
	private func fetchPhotosBasedOnScrollPosition(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let scrollHeight = scrollView.frame.size.height
		if ( offsetY >= (contentHeight - scrollHeight) ) {
			let nextPage = searchImageData.getCurrentPage() + 1
			
			guard !fetchedPages.contains(nextPage),
						!isFetching,
						let text = searchImageData.searchText else { return }
			isFetching = true
			searchPhotos(text, nextPage)
		}
	}
}
