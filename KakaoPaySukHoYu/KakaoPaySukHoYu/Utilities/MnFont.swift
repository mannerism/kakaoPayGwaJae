//
//  MnFont.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

enum MNFont {
	case light(fontSize: CGFloat)
	case bold(fontSize: CGFloat)
	
	var font: UIFont? {
		switch self {
		case .light(let fontSize):
			return UIFont(name: "Gilroy-Light", size: fontSize)
		case .bold(let fontSize):
			return UIFont(name: "Gilroy-ExtraBold", size: fontSize)
		}
	}
}
