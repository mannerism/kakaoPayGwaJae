//
//  EndPoints.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import Foundation

enum EndPoint: CustomStringConvertible {
	case photos
	case singleRandom
	case search
	
	var description: String {
		switch self {
		case .photos:
			return baseURL + "photos"
		case .singleRandom:
			return baseURL + "photos/random"
		case .search:
			return baseURL + "search/photos"
		}
	}
}
