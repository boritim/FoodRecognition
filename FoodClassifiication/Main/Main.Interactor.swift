//
//  Main.Interactor.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 5.06.2023.
//

import UIKit
import CoreData

enum InteractorError: Error {

	case failedDecoding
}

extension Main {

	final class Interactor {

		private let networkService: NetworkServiceProtocol
		private let coreDataContainer: CoreDataContainer

		init(networkService: NetworkServiceProtocol, coreDataContainer: CoreDataContainer) {
			self.networkService = networkService
			self.coreDataContainer = coreDataContainer
		}

		func loadFood(with image: UIImage, weight: Float) throws -> Model {
			let data = networkService.load(image: image, weight: weight)

			guard let model = try? JSONDecoder().decode(Model.self, from: data) else {
				throw InteractorError.failedDecoding
			}

			saveFood(model: model)
			return model
		}

		private func saveFood(model: Model) {
			coreDataContainer.perfom { _ in
				let request = NSFetchRequest<MFood>(entityName: "MFood")
				let count = try? coreDataContainer.viewContext.count(for: request)
				let mfood = MFood(context: coreDataContainer.viewContext)
				mfood.id = Int64(count ?? 0)
				mfood.foods = makeDict(foods: model.foods)
				mfood.recommendations = makeDict(foods: model.recommendations)
				mfood.url = ""
			}
		}

		private func getFood() -> [MFood] {
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MFood")
			let results = try? coreDataContainer.viewContext.fetch(fetchRequest) as? [MFood]
			return results ?? []
		}

		private func makeDict(foods: [Main.Model.Food]) -> [String: [String]] {
			foods.reduce([String: [String]]()) { (result, food) -> [String: [String]] in
				var result = result
				result[food.name] = [food.protein, food.fat, food.carbohydrate]
				return result
			}
		}
	}
}
