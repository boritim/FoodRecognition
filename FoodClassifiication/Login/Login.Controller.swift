//
//  Login.Controller.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 02.06.2023.
//

import UIKit
import FirebaseAuth

extension Login {

	final class Controller: UIViewController {

		private let loginView = Login.View()
		let testVerificationID = "123456"

		// MARK: - Life Cycle

		override func loadView() {
			view = loginView
		}

		override func viewDidLoad() {
			super.viewDidLoad()

			navigationItem.hidesBackButton = true
			hideKeyboardWhenTappedAround()
		}

		override func viewWillLayoutSubviews() {
			super.viewWillLayoutSubviews()

			loginView.phoneTextField.delegate = self
			loginView.phoneTextField.becomeFirstResponder()
			loginView.output = self
		}

		// MARK: - Private functions

		private func alertInvalidPhoneNumber() {
			let alert = UIAlertController(title: "Error",
										  message: "Please Write Phone number",
										  preferredStyle: .alert)
			let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default) { _ in NSLog("The \"OK\" alert occured.")}
			alert.addAction(alertAction)
			self.present(alert, animated: true, completion: nil)
		}

		private func hideKeyboardWhenTappedAround() {
			let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
			tap.cancelsTouchesInView = false
			view.addGestureRecognizer(tap)
		}

		@objc private func dismissKeyboard() {
			loginView.phoneTextField.endEditing(true)
		}
	}
}

// MARK: - TextFieldDelegate

extension Login.Controller: UITextFieldDelegate {

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text else { return false }

		let newString = (text as NSString).replacingCharacters(in: range, with: string)
		textField.text = format(with: "(XXX) XXX-XX-XX", phone: newString)
		return false
	}

	func format(with mask: String, phone: String) -> String {
		let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
		var result = ""
		var index = numbers.startIndex

		for ch in mask where index < numbers.endIndex {
			if ch == "X" {
				result.append(numbers[index])
				index = numbers.index(after: index)
				continue
			}
			result.append(ch)
		}
		return result
	}
}

// MARK: - LoginViewOutput

extension Login.Controller: LoginViewOutput {

	func validate(phoneNumber: String) {
		guard phoneNumber.count == 15 else { return alertInvalidPhoneNumber() }

//		 TODO: Открыть стартовый экран

		let russianNumber = "+7 " + phoneNumber
		PhoneAuthProvider.provider().verifyPhoneNumber(russianNumber, uiDelegate: nil) { (verificationID, error) in
			if let error = error {
				print("Error:\n\(error.localizedDescription)")
				return
			}
			let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: self.testVerificationID)
			Auth.auth().signIn(with: credential) { authData, error in
				if let error = error {
					print("Error:\n\(error.localizedDescription)")
					return
				}
				let user = authData?.user
				print("Created user: \(user!)")
				UserDefaults.standard.set(true, forKey: "logged_in")
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
}
