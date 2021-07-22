//
//  ImageDetailCell.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/28.
//

import UIKit

class ImageDetailCell: UICollectionViewCell {
	// MARK: - Properties
	var onReuse: () -> Void = { }

	lazy var scrollView: UIScrollView = {
		let sv = UIScrollView()
		sv.delegate = self
		sv.minimumZoomScale = 1.0
		sv.maximumZoomScale = 4.0
		sv.showsHorizontalScrollIndicator = false
		sv.showsVerticalScrollIndicator = false
		return sv
	}()
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .clear
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
		addViews()
		setConstraints()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		onReuse()
		imageView.image = nil
	}
	
	required init?(coder: NSCoder) {
		return nil
	}
	
	// MARK: - Setup
	private func setup() {

	}
	
	private func addViews() {
		scrollView.addSubview(imageView)
		addSubview(scrollView)
	}
	
	private func setConstraints() {
		scrollViewConstraints()
		imageViewConstraints()
	}
	
	private func configureImageView() {
		imageView.backgroundColor = .black
	}
	
	// MARK: - Handlers
	
	// MARK: - Constraints
	private func scrollViewConstraints() {
		scrollView.anchor(
			top: topAnchor,
			leading: leadingAnchor,
			bottom: bottomAnchor,
			trailing: trailingAnchor)
	}
	
	private func imageViewConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
		imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
	}
}

extension ImageDetailCell: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
