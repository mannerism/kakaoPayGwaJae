//
//  Double+Extension.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/24.
//

import UIKit

//MARK: - Autolayout adjustables
var screenSize: CGSize = UIScreen.main.bounds.size

extension Double {
	var h: CGFloat {
		let frame = screenSize
		var adjusted = self * (Double(frame.height) / 844)
		let ratio = adjusted / self
		if ratio < 0.7 {
			adjusted = self * 0.7
		} else if ratio > 1.4 {
			adjusted = self * 1.4
		}
		return CGFloat(adjusted)
	}
	
	var w: CGFloat {
		let frame = screenSize
		var adjusted = self * (Double(frame.width) / 390)
		let ratio = adjusted / self
		if ratio < 0.7 {
			adjusted = self * 0.7
		} else if ratio > 1.4 {
			adjusted = self * 1.4
		}
		return CGFloat(adjusted)
	}
}
