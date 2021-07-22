//
//  HomeHeader.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/26.
//

import UIKit

class HomeHeader: UICollectionReusableView {
	
	var photoData: Photo? {
		didSet {
			guard let photo = self.photoData else { return }
			self.backgroundColor = UIColor(hexString: photo.colorCode)
			let userName = NSMutableAttributedString(
				string: "by ",
				attributes:[
					NSAttributedString.Key.foregroundColor: UIColor.white,
					NSAttributedString.Key.font: MNFont.light(fontSize: 13).font!
				]
			)
			userName.append(
				NSMutableAttributedString(
					string: photo.user.name!,
					attributes:[
						NSAttributedString.Key.font: MNFont.bold(fontSize: 13).font!,
						NSAttributedString.Key.foregroundColor: UIColor.white
					]
				)
			)
			self.nameLabel.attributedText = userName
		}
	}
	
	var onReuse: () -> Void = { }
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		return iv
	}()
	
	let mainLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.font = MNFont.bold(fontSize: 27).font
		lb.text = "Photos for everyone"
		lb.textAlignment = .center
		lb.textColor = .white
		lb.numberOfLines = 1
		return lb
	}()
	
	let nameLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.font = MNFont.bold(fontSize: 12).font
		lb.textColor = .white
		lb.textAlignment = .center
		lb.numberOfLines = 1
		return lb
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
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
	
	private func addViews() {
		addSubviews(
			imageView,
			mainLabel,
			nameLabel)
	}
	
	private func setConstraints() {
		imageViewConstraints()
		mainLabelConstraints()
		nameLabelConstraints()
	}
	
	private func imageViewConstraints() {
		imageView.anchor(
			top: topAnchor,
			leading: leadingAnchor,
			bottom: bottomAnchor,
			trailing: trailingAnchor)
	}
	
	private func mainLabelConstraints() {
		mainLabel.translatesAutoresizingMaskIntoConstraints = false
		mainLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
		mainLabel.heightAnchor.constraint(equalToConstant: 40.h).isActive = true
		mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20.h).isActive = true
	}
	
	private func nameLabelConstraints() {
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: 20.h).isActive = true
		nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40.h).isActive = true
	}
}
