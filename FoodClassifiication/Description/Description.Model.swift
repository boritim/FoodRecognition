//
//  Description.Model.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 7.06.2023.
//

import UIKit

extension Description {

	struct Model {

		let image: UIImage

		let foods: [Food]

		let recommendations: [Food]
	}
}

extension Description.Model {

	struct Food {

		let name: String

		let calories: String

		let protein: String

		let fat: String

		let carbohydrate: String
	}
}
