//
//  IndicatorView.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 15.06.2023.
//

import UIKit

final class IndicatorView: UIView {
	private lazy var indicatorView: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .large)
		indicator.color = .black
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()

	init() {
		super.init(frame: .zero)
		self.addSubview(indicatorView)
		NSLayoutConstraint.activate([
			indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func showSpinner(isShown: Bool) {
		if isShown {
			indicatorView.startAnimating()
		} else {
			indicatorView.stopAnimating()
		}
	}
}
