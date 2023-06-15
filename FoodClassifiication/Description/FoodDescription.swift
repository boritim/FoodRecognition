//
//  FoodDescription.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 7.06.2023.
//

import UIKit

final class FoodDescription: UIView {

	private enum FoodType: String {
		case protein = "Белок"
		case fat = "Жиры"
		case carbohydrate = "Углеводы"
		case calories = "Калории"
	}

	private let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let stackView: UIStackView = {
		let stackVuew = UIStackView()
		stackVuew.axis = .vertical
		stackVuew.spacing = 8
		stackVuew.translatesAutoresizingMaskIntoConstraints = false
		return stackVuew
	}()

	init(name: String, calories: String, protein: String, fat: String, carbohydrate: String) {
		super.init(frame: .zero)
		setuoUI()
		configure(name, calories, protein, fat, carbohydrate)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setuoUI() {
		[label, stackView].forEach { addSubview($0) }

		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: topAnchor),
			label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			label.rightAnchor.constraint(equalTo: rightAnchor),

			stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
			stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	private func configure(_ name: String, _ calories: String, _ protein: String, _ fat: String, _ carbohydrate: String) {
		label.text = name
		stackView.addArrangedSubview(createLabel(type: .calories, text: calories))
		stackView.addArrangedSubview(createLabel(type: .protein, text: protein))
		stackView.addArrangedSubview(createLabel(type: .fat, text: fat))
		stackView.addArrangedSubview(createLabel(type: .carbohydrate, text: carbohydrate))
	}

	private func createLabel(type: FoodType, text: String) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12, weight: .medium)
		label.text = " - \(type.rawValue): \(text)"
		return label
	}
}
