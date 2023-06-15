//
//  Login.View.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 02.06.2023.
//

import UIKit

extension Login {

	final class View: UIView {

		// MARK: - Private properties

		private enum Constants {
			static let appNameLabelSize: CGSize = .init(width: 90.0, height: 20.0)
		}

		private let appNameLabel: UILabel = {
			var label = UILabel()
			label.text = "Food\nClassification"
			label.textAlignment = .center
			label.numberOfLines = 2
			label.lineBreakMode = .byWordWrapping
			label.font = .systemFont(ofSize: 40.0, weight: .bold)
			return label
		}()

		let phoneTextField: UITextField = {
			var textField = UITextField()
			textField.keyboardType = .numberPad
			textField.clearButtonMode = .whileEditing
			textField.layer.cornerRadius = 12
			textField.layer.borderWidth = 1
			textField.layer.borderColor = UIColor.lightGray.cgColor
			textField.placeholder = "Phone number..."
			textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
			textField.leftViewMode = .always
			return textField
		}()

		private let russianCodeLabel: UILabel = {
			var label = UILabel()
			label.text = "+7"
			return label
		}()

		private lazy var doneButton: UIButton = {
			var button = UIButton()
			button.setTitle("Sign in", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
			button.backgroundColor = .systemBlue
			button.layer.cornerRadius = 12
			button.layer.masksToBounds = true
			button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
			return button
		}()

		private let phoneStackView: UIStackView = {
			let stackView = UIStackView()
			stackView.spacing = 5
			stackView.axis = .horizontal
			return stackView
		}()

		// MARK: - Public functions

		weak var output: LoginViewOutput?

		// MARK: - Init

		override init(frame: CGRect = .zero) {
			super.init(frame: frame)
			backgroundColor = .white
			setupUI()
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		// MARK: - Public functions

		func configure(phoneNumber: String) {
		}

		// MARK: - Private functions

		private func setupUI() {
			phoneStackView.addArrangedSubview(russianCodeLabel)
			phoneStackView.addArrangedSubview(phoneTextField)
			[appNameLabel, phoneStackView, doneButton].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
				addSubview($0)
			}

			let screenWidth = UIScreen.main.bounds.width
			let viewSize = screenWidth / 3
			NSLayoutConstraint.activate([

				appNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
				appNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),

				phoneStackView.centerXAnchor.constraint(equalTo: appNameLabel.centerXAnchor),
				phoneStackView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 20),

				doneButton.centerXAnchor.constraint(equalTo: phoneStackView.centerXAnchor),
				doneButton.topAnchor.constraint(equalTo: phoneStackView.bottomAnchor, constant: 20),
				doneButton.widthAnchor.constraint(equalToConstant: 100),
				doneButton.heightAnchor.constraint(equalToConstant: 50),

				phoneTextField.widthAnchor.constraint(equalToConstant: screenWidth - viewSize),
				phoneTextField.heightAnchor.constraint(equalToConstant: 30),
			])
		}

		@objc private func signInTapped() {
			guard let phoneNumber = phoneTextField.text else { return }

			output?.validate(phoneNumber: phoneNumber)
		}
	}
}
