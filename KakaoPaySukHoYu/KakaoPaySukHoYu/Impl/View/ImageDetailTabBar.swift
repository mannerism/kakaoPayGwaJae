//
//  ImageDetailTabBar.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/29.
//

import UIKit

class ImageDetailTabBar: UIView {
	// MARK: - Properties
	let nameLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.textAlignment = .center
		lb.font = MNFont.bold(fontSize: 12).font
		lb.textColor = .white
		return lb
	}()
	
	let sponsorLabel: UILabel = {
		let lb = UILabel()
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.7
		lb.textAlignment = .center
		lb.font = MNFont.light(fontSize: 12).font
		lb.textColor = .white
		return lb
	}()
	
	let backButton: UIButton = {
		let bt = UIButton(type: .custom)
		let image = UIImage(named: "backicon")?
			.withRenderingMode(.alwaysOriginal)
			.withTintColor(.white)
		bt.setImage(image, for: .normal)
		bt.imageView?.contentMode = .scaleAspectFit
		return bt
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
		addViews()
		setConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let gradient = CAGradientLayer()
		gradient.frame = bounds
		gradient.colors = [
			UIColor.init(white: 0, alpha: 0.8).cgColor,
			UIColor.clear.cgColor
		]
		gradient.locations = [0.0, 0.75]
		layer.insertSublayer(gradient, at: 0)
	}
	
	required init?(coder: NSCoder) {
		return nil
	}
	
	// MARK: - Setup
	private func setup() {
		backgroundColor = .clear
	}
	
	private func addViews() {
		addSubviews(
			nameLabel,
			sponsorLabel,
			backButton
		)
	}
	
	private func setConstraints() {
		nameLabelConstraints()
		sponsorLabelConsraints()
		backButtonConstraints()
	}
	
	// MARK: - Handlers
	func toggleTabBar() {
		if alpha == 1 {
			UIView.animate(withDuration: 0.3) {
				self.alpha = 0
			}
		} else {
			UIView.animate(withDuration: 0.3) {
				self.alpha = 1
			}
		}
	}
	// MARK: - Constraints
	private func nameLabelConstraints() {
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: 15.h).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
		nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
	}
	
	private func sponsorLabelConsraints() {
		sponsorLabel.translatesAutoresizingMaskIntoConstraints = false
		sponsorLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
		sponsorLabel.heightAnchor.constraint(equalToConstant: 15.h).isActive = true
		sponsorLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
		sponsorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
	}
	
	private func backButtonConstraints() {
		backButton.translatesAutoresizingMaskIntoConstraints = false
		backButton.widthAnchor.constraint(equalToConstant: 50.w).isActive = true
		backButton.heightAnchor.constraint(equalToConstant: 50.h).isActive = true
		backButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
}

