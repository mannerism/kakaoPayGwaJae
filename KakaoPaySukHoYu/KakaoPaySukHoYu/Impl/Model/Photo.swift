//
//  Photo.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

struct Response: Codable {
	let total: Double
	let totalPages: Int
	let photos: [Photo]
	
	enum CodingKeys: String, CodingKey {
		case total
		case totalPages = "total_pages"
		case photos = "results"
	}
}

struct Photo: Codable {
	let id: String
	let width: Double
	let height: Double
	let colorCode: String
	let blurHash: String
	let description: String?
	let urls: Urls
	let sponsorship: Sponsorship?
	let user: User
	
	enum CodingKeys: String, CodingKey {
		case id
		case width
		case height
		case blurHash = "blur_hash"
		case colorCode = "color"
		case description = "alt_description"
		case urls
		case sponsorship
		case user
	}
	
	func getCellSize(_ collectionView: UICollectionView) -> CGSize {
		let width = collectionView.frame.width
		let height = CGFloat(self.height / self.width) * width
		return CGSize(
			width: width,
			height: height)
	}
}

struct Urls: Codable {
	let small: String?
	let regular: String?
}

struct Sponsorship: Codable {
	let tagline: String
}

struct User: Codable {
	let name: String?
}
