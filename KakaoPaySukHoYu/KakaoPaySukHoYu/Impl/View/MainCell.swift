//
//  HomeCell.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/25.
//

import UIKit

class MainCell: UICollectionViewCell {
	
	// MARK: - Properties
	var photoData: Photo? {
		didSet {
			guard let photo = self.photoData else { return }
			self.backgroundColor = UIColor(hexString: photo.colorCode)
			self.usernameLabel.text = photo.user.name
			self.sponsorLabel.text = (photo.sponsorship != nil)
				? "Sponsored"
				: nil
		}
	}
	
	var onReuse: () -> Void = { }
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFit
		iv.backgroundColor = .clear
		return iv
	}()
	
	let usernameLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.font = MNFont.bold(fontSize: 12).font
		lb.textColor = .white
		lb.numberOfLines = 1
		return lb
	}()
	
	let sponsorLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.font = MNFont.light(fontSize: 12).font
		lb.textColor = .white
		lb.numberOfLines = 1
		return lb
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		return nil
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		onReuse()
		imageView.image = nil
	}
	
	// MARK: - Handlers
	private func addViews() {
		addSubviews(
			imageView,
			usernameLabel,
			sponsorLabel
		)
	}
	
	private func setConstraints() {
		imageViewConstraints()
		usernameLabelConstraints()
		sponsorLabelConstraints()
	}
	
	// MARK: - Constraints
	private func imageViewConstraints() {
		imageView.anchor(
			top: topAnchor,
			leading: leadingAnchor,
			bottom: bottomAnchor,
			trailing: trailingAnchor)
	}
	
	private func usernameLabelConstraints() {
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		usernameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
		usernameLabel.heightAnchor.constraint(equalToConstant: 12.h).isActive = true
		usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.w).isActive = true
		usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.h).isActive = true
	}
	
	private func sponsorLabelConstraints() {
		sponsorLabel.translatesAutoresizingMaskIntoConstraints = false
		sponsorLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
		sponsorLabel.heightAnchor.constraint(equalToConstant: 12.h).isActive = true
		sponsorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.w).isActive = true
		sponsorLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5.h).isActive = true
	}
}
