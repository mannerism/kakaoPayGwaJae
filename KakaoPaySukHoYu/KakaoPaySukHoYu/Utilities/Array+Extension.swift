//
//  Array+Extension.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/27.
//

import Foundation

extension Collection {
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
