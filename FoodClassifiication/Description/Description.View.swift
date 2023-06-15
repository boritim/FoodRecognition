//
//  Description;View.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 7.06.2023.
//

import UIKit

extension Description {

	final class View: UIView {

		private let scrollView: UIScrollView = {
			let scrollView = UIScrollView()
			scrollView.showsVerticalScrollIndicator = false
			return scrollView
		}()

		private let imageView: UIImageView = {
			let imageView = UIImageView()
//			imageView.contentMode = .scaleAspectFill
			return imageView
		}()

		private let foodLabel: UILabel = {
			let label = UILabel()
			label.font = .systemFont(ofSize: 24.0, weight: .bold)
			label.text = "Найденые блюда:"
			return label
		}()

		private let foodStackView: UIStackView = {
			let stackView = UIStackView()
			stackView.axis = .vertical
			stackView.spacing = 10
			stackView.translatesAutoresizingMaskIntoConstraints = false
			return stackView
		}()

		private let recomLabel: UILabel = {
			let label = UILabel()
			label.font = .systemFont(ofSize: 24.0, weight: .bold)
			label.text = "Рекомендации к блюду:"
			return label
		}()

		init() {
			super.init(frame: .zero)
			backgroundColor = .white
			setupUI()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func setupUI() {
			[imageView, scrollView].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
				addSubview($0)
			}

			scrollView.addSubview(foodStackView)
			NSLayoutConstraint.activate([
				imageView.leftAnchor.constraint(equalTo: leftAnchor),
				imageView.rightAnchor.constraint(equalTo: rightAnchor),
				imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
				imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),

				scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
				scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
				scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
				scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

				foodStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
				foodStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
				foodStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
				foodStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
			])
		}

		func configure(model: Model) {
			imageView.image = model.image
			foodStackView.addArrangedSubview(foodLabel)
			model.foods.forEach {
				let view = FoodDescription(name: $0.name, calories: $0.calories, protein: $0.protein, fat: $0.fat, carbohydrate: $0.carbohydrate)
				foodStackView.addArrangedSubview(view)
			}
			foodStackView.addArrangedSubview(recomLabel)
			model.recommendations.forEach {
				let view = FoodDescription(name: $0.name, calories: $0.calories, protein: $0.protein, fat: $0.fat, carbohydrate: $0.carbohydrate)
				foodStackView.addArrangedSubview(view)
			}
		}
	}
}
