//
//  Main.Controller.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 03.06.2023.
//

import UIKit

extension Main {

	final class Controller: UIViewController {

		// MARK: - Private properties

		private let mainView = Main.View()
		private let interactor = Interactor(networkService: MockNetworkService(), coreDataContainer: CoreDataContainer())
		private let weightView = WeightView()

		private var pickerDismiss = false
		private var index = 0

		private var models: [Description.Model] = []

		private var pickerView: UIPickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
		private var pickerData: [Double] = []
		private var pickerValue: Double = 72.0

		// MARK: - LifeCycle

		override func loadView() {
			super.loadView()
			view = mainView
		}

		override func viewDidLoad() {
			super.viewDidLoad()
			configureNavigationBar()
			configureCollectionView()
			configurePickerView()
		}

		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			if pickerDismiss {
				mainView.indicatorView.isHidden = false
				DispatchQueue.main.async { [weak self] in
					guard let self else { return }

					let vc = Description.Controller(model: self.models[self.index])
					self.index += 1
					sleep(5)
					self.navigationController?.pushViewController(vc, animated: true)
					self.mainView.collectionView.reloadData()
					self.pickerDismiss = false
					self.mainView.indicatorView.isHidden = true
				}
			}
		}

		// MARK: - Private functions

		private func configureCollectionView() {
			mainView.collectionView.delegate = self
			mainView.collectionView.dataSource = self
			mainView.output = self
		}

		private func configureNavigationBar() {
			navigationController?.navigationBar.barTintColor = .white
			navigationItem.title = "Классификатор блюд"
			navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
			navigationItem.rightBarButtonItem?.tintColor = .black
			let secondItem = UIBarButtonItem(customView: weightView)
			weightView.output = self
			weightView.changeWeight(value: 72.0)
			let image = UIImage(named: "logout")
			let firstItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(logout))
			navigationItem.rightBarButtonItems = [firstItem, secondItem]
			navigationItem.rightBarButtonItems?.forEach {
				$0.tintColor = .black
			}
		}

		private func configurePickerView() {
			pickerView.delegate = self
			pickerView.dataSource = self

			let minNum = 20.0
			let maxNum = 120.0
			pickerData = Array(stride(from: minNum, to: maxNum + 1.0, by: 0.5))
		}

		@objc private func logout() {
			let vc = Login.Controller()
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

// MARK: - WeightViewOutput

extension Main.Controller: WeightViewOutput {

	func showAlert() {
		let ac = UIAlertController(title: "Picker", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
		ac.view.addSubview(pickerView)
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			let pickerValue = self.pickerData[self.pickerView.selectedRow(inComponent: 0)]
			print("Picker value: \(pickerValue) was selected")
			self.pickerValue = pickerValue
			self.weightView.changeWeight(value: pickerValue)
		}))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(ac, animated: true)
	}
}

// MARK: - MainViewOutput

extension Main.Controller: MainViewOutput {

	func scannningTapped() {
		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
			let alertController = UIAlertController(title: nil, message: "Разрешите доступ к камере в настройках", preferredStyle: .alert)
			let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in })
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)
			return
		}
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.allowsEditing = true
		vc.delegate = self
		present(vc, animated: true)
	}
}

// MARK: - UIImagePickerControllerDelegate

extension Main.Controller: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: false)
		pickerDismiss = true

		guard let image = info[.editedImage] as? UIImage else { return print("No image found") }

		let model = try? interactor.loadFood(with: image, weight: 72.0)
		let descriptionModel = Description.Model(image: image,
												 foods: (model?.foods ?? []).map {
			Description.Model.Food(name: $0.name,
								   calories: $0.calories,
								   protein: $0.protein,
								   fat: $0.fat,
								   carbohydrate: $0.carbohydrate)
		},
												 recommendations: (model?.recommendations ?? []).map {
			Description.Model.Food(name: $0.name,
								   calories: $0.calories,
								   protein: $0.protein,
								   fat: $0.fat,
								   carbohydrate: $0.carbohydrate)
		})
		models.append(descriptionModel)
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension Main.Controller: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return models.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.CollectionViewCell.identifier,
															for: indexPath) as? Main.CollectionViewCell
		else { return UICollectionViewCell()}

		cell.configure(image: models[indexPath.item].image)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)

		let vc = Description.Controller(model: models[indexPath.item])
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension Main.Controller: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let layout = mainView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
		layout?.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
		layout?.minimumInteritemSpacing = 3
		layout?.minimumLineSpacing = 3

		let size = (mainView.frame.width - 32) / 3
		return .init(width: size - 4, height: size - 4)
	}
}

extension Main.Controller: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return "\(pickerData[row])"
	}
}

protocol WeightViewOutput: AnyObject {

	func showAlert()
}

final class WeightView: UIView {

	private let weightLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 16.0)
		return label
	}()

	weak var output: WeightViewOutput?

	init() {
		super.init(frame: .zero)
		setupUI()
		let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
		addGestureRecognizer(gesture)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func tapped() {
		output?.showAlert()
	}

	private func setupUI() {
		addSubview(weightLabel)

		NSLayoutConstraint.activate([
			weightLabel.topAnchor.constraint(equalTo: topAnchor),
			weightLabel.leftAnchor.constraint(equalTo: leftAnchor),
			weightLabel.rightAnchor.constraint(equalTo: rightAnchor),
			weightLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	func changeWeight(value: Double) {
		weightLabel.text = "\(value)"
	}
}
