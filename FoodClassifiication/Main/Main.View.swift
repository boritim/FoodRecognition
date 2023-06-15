//
//  Main.View.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 03.06.2023.
//

import UIKit

extension Main {

	final class View: UIView {

		// MARK: - Private properties

		private(set) var collectionView: UICollectionView = {
			let layout = UICollectionViewFlowLayout()
			let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
			view.backgroundColor = .white
			view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
			return view
		}()

		private let scanButton: UIButton = {
			let button = UIButton()
			button.setTitle("Сканирововать", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
			button.backgroundColor = .systemBlue
			button.layer.cornerRadius = 12
			button.layer.masksToBounds = true
			return button
		}()

		private(set) var indicatorView = IndicatorView()

		// MARK: - Public properties

		weak var output: MainViewOutput?

		// MARK: - Init

		init() {
			super.init(frame: .zero)
			backgroundColor = .white
			setupUI()
			indicatorView.showSpinner(isShown: true)
			scanButton.addTarget(self, action: #selector(scanningTapped), for: .touchUpInside)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		// MARK: - Public functions

		func updateCollectioViewData(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
			collectionView.delegate = delegate
			collectionView.dataSource = dataSource
			collectionView.reloadData()
		}

		// MARK: - Private functions

		private func setupUI() {
			[collectionView, scanButton, indicatorView].forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
				addSubview($0)
			}

			NSLayoutConstraint.activate([
				indicatorView.leftAnchor.constraint(equalTo: leftAnchor),
				indicatorView.rightAnchor.constraint(equalTo: rightAnchor),
				indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
				indicatorView.topAnchor.constraint(equalTo: topAnchor),

				scanButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
				scanButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
				scanButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
				scanButton.heightAnchor.constraint(equalToConstant: 75),

				collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
				collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
				collectionView.bottomAnchor.constraint(equalTo: scanButton.topAnchor),
				collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
			])
			indicatorView.isHidden = true
		}

		@objc private func scanningTapped(sender: UIButton) {
			sender.showAnimation { [weak self] in
				self?.output?.scannningTapped()
			}
		}
	}
}
