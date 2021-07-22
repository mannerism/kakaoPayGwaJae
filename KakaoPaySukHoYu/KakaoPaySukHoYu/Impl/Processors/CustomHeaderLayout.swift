//
//  CustomHeaderLayout.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/26.
//

import UIKit

class CustomHeaderLayout: UICollectionViewFlowLayout {
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let layoutAttribute = super.layoutAttributesForElements(in: rect)
		layoutAttribute?.forEach { attribute in
			if attribute.representedElementKind == UICollectionView.elementKindSectionHeader &&
					attribute.indexPath.section == 0 {
				guard let collectionView = collectionView else { return }
				let contentOffsetY = collectionView.contentOffset.y
				let width = collectionView.frame.width
				let height = attribute.frame.height - contentOffsetY
				
				if contentOffsetY > 0 {
					return
				}
				
				attribute.frame = CGRect(
					x: 0,
					y: contentOffsetY,
					width: width,
					height: height)
			}
		}
		return layoutAttribute
	}
	
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		// So that it recalculates simultaneously
		return true
	}
}
