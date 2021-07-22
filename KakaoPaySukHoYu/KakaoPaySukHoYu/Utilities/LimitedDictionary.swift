//
//  LimitedDictionary.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/27.
//

import Foundation
struct LimitedDictionary<T: Hashable, U> {
	private let limit: UInt
	private var dictionary = [T: U]()
	
	init(limit: UInt) {
		self.limit = limit
	}
	
	subscript(key: T) -> U? {
		get {
			return dictionary[key]
		}
		set {
			let keys = dictionary.keys
			if keys.count < limit || keys.contains(key) {
				dictionary[key] = newValue
			}
		}
	}
	
	func getDictionary() -> [T: U] {
		return dictionary
	}
	
	mutating func removeAll() {
		dictionary.removeAll()
	}
}
