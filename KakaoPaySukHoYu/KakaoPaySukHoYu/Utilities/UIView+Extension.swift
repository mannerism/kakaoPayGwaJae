//
//  UIView+Extension.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

public struct AnchoredConstraints {
	public var top: NSLayoutConstraint?
	public var leading: NSLayoutConstraint?
	public var bottom: NSLayoutConstraint?
	public var trailing: NSLayoutConstraint?
	public var width: NSLayoutConstraint?
	public var height: NSLayoutConstraint?
	public var centerX: NSLayoutConstraint?
	public var centerY: NSLayoutConstraint?
}

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
	
	@discardableResult
	func anchor(
		top: NSLayoutYAxisAnchor?,
		leading: NSLayoutXAxisAnchor?,
		bottom: NSLayoutYAxisAnchor?,
		trailing: NSLayoutXAxisAnchor?,
		padding: UIEdgeInsets = .zero,
		size: CGSize = .zero
	) -> AnchoredConstraints {
		
		translatesAutoresizingMaskIntoConstraints = false
		var anchoredConstraints = AnchoredConstraints()
		
		if let top = top {
			anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
		}
		
		if let leading = leading {
			anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
		}
		
		if let bottom = bottom {
			anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
		}
		
		if let trailing = trailing {
			anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
		}
		
		if size.width != 0 {
			anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
		}
		
		if size.height != 0 {
			anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
		}
		
		[
			anchoredConstraints.top,
			anchoredConstraints.leading,
			anchoredConstraints.bottom,
			anchoredConstraints.trailing,
			anchoredConstraints.width,
			anchoredConstraints.height
		].forEach{ $0?.isActive = true }
		
		return anchoredConstraints
	}
}




