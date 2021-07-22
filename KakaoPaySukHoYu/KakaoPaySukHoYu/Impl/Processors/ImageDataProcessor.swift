//
//  ImageDataProcessor.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/27.
//

import Foundation

class ImageDataProcessor {
	var headerPhoto: Photo!
	var photos: [Photo] = []
	var searchText: String!
	
	func addPhotos(_ newPhotos: [Photo]) {
		photos += newPhotos
	}
	
	func setHeaderPhoto(_ photo: Photo) {
		headerPhoto = photo
	}
	
	func removeSearchVariables() {
		photos.removeAll()
		removeSearchText()
	}
	
	func getCurrentPage() -> Int {
		if (photos.count % 10) == 0 {
			return photos.count / 10
		} else {
			return (photos.count / 10) + 1
		}
	}
	
	func setSearchText(_ text: String) {
		self.searchText = text
	}
	
	private func removeSearchText() {
		searchText = nil
	}
}
