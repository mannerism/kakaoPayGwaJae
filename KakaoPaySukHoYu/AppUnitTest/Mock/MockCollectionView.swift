//
//  MockCollectionView.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit

class MockCollectionView: UICollectionView {
	var didRun: Bool = false
	
	override func scrollToItem(
		at indexPath: IndexPath,
		at scrollPosition: UICollectionView.ScrollPosition,
		animated: Bool) {
		didRun = true
	}
}
