//
//  NetworkService.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 6.06.2023.
//

import UIKit

protocol NetworkServiceProtocol {

	func load(image: UIImage, weight: Float) -> Data
}

final class NetworkService: NetworkServiceProtocol {

	func load(image: UIImage, weight: Float) -> Data {
		return Data()
	}
}

final class MockNetworkService: NetworkServiceProtocol {

	private var calledCount = 0

	func load(image: UIImage, weight: Float) -> Data {
		var model: Main.Model?

		if calledCount % 2 == 0 {
			model = Main.Model(
				foods: [
				.init(name: "Оливье", calories: "172.1 ккал.", protein: "6.9 г.", fat: "14.4 г.", carbohydrate: "3.8 г."),
				.init(name: "Куриная котлета", calories: "133.5 ккал.", protein: "18.4 г.", fat: "4.7 г.", carbohydrate: "4.5 г.")
			],
				recommendations: [
					.init(name: "Бананы", calories: "96 ккал.", protein: "1.5 г.", fat: "0.5 г.", carbohydrate: "21 г.")
			])
		} else {
			model = Main.Model(
				foods: [
				.init(name: "Борщ", calories: "49 ккал.", protein: "1.1 г.", fat: "2.2 г.", carbohydrate: "6.7 г.")
			],
				recommendations: [
					.init(name: "Гуляш куриный", calories: "92.5 ккал.", protein: "11.2 г.", fat: "4.3 г.", carbohydrate: "2.2 г."),
					.init(name: "Пюре картофельное", calories: "128.9 ккал.", protein: "2.6 г.", fat: "4.2 г.", carbohydrate: "20 г."),
					.init(name: "Витаминный салат", calories: "53.2 ккал.", protein: "0.8 г.", fat: "0.3 г.", carbohydrate: "11.4 г.")
			])
		}
		calledCount += 1

		do {
			let data = try JSONEncoder().encode(model!)
			return data
		} catch {
			print("Failed encode Main.Model")
			return Data()
		}
	}
}
