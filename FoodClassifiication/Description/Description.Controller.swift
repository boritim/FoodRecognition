//
//  Description.Controller.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 7.06.2023.
//

import UIKit

extension Description {

	final class Controller: UIViewController {

		private let descriptionView = Description.View()
		private let model: Model

		override func loadView() {
			super.loadView()
			view = descriptionView
		}

		override func viewDidLoad() {
			super.viewDidLoad()
			view.backgroundColor = .white
		}

		override func viewDidLayoutSubviews() {
			super.viewDidLayoutSubviews()

			descriptionView.configure(model: model)
		}

		init(model: Model) {
			self.model = model
			super.init(nibName: nil, bundle: nil)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}
