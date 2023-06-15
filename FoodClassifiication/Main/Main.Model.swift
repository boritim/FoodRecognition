//
//  Main.Model.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 03.06.2023.
//

import Foundation

extension Main {

	struct Model: Codable {

		let foods: [Food]

		let recommendations: [Food]
	}
}

extension Main.Model {

	struct Food: Codable {

		let name: String

		let calories: String

		let protein: String

		let fat: String

		let carbohydrate: String
	}
}
