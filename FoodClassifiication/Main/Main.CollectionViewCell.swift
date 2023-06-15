//
//  Main.CollectionViewCell.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 4.06.2023.
//

import UIKit

extension Main {

	final class CollectionViewCell: UICollectionViewCell {

		static let identifier = "MainCollectionViewCell"

		private let imageView: UIImageView = {
			let imageView = UIImageView()
			imageView.translatesAutoresizingMaskIntoConstraints = false
			return imageView
		}()

		// MARK: - Init

		override init(frame: CGRect) {
			super.init(frame: frame)
			contentView.addSubview(imageView)
			NSLayoutConstraint.activate([
				imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
				imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
				imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
				imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
			])
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		func configure(image: UIImage) {
			imageView.image = image
		}
	}
}
