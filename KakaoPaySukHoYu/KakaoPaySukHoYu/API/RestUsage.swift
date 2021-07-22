//
//  RestUsage.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/24.
//

import Foundation

enum RestUsage {
	case Photos(page: Int)
	case ARandomPhoto
	case Search(page: Int, searchText: String)
}
