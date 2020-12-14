//
//  DogsViewController.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

/// Class created to show each dog breed.
class DogsViewController: UIViewController {
	// MARK: Properties
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		collectionView.backgroundColor = .none
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private let viewModel: DogsViewModel
	private let coordinator: DogCoordinator
	
	// MARK: init()
	init(viewModel: DogsViewModel, coordinator:DogCoordinator ) {
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		addLogoutButton()
		addSubviews()
		self.view.backgroundColor = .systemGray6
		collectionView.delegate = self
		collectionView.dataSource = self
		setupCollectionViewConstraints()
		registerCell()
	}
	
	// MARK: addSubviews()
	/// Adds created subview to view.
	private func addSubviews() {
		self.view.addSubview(collectionView)
	}
	
	// MARK: Navigation
	/// Sets the right button of `UINavigation`.
	private func addLogoutButton () {
		navigationItem.setRightBarButton(UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(askingLogout)), animated: true)
	}
	
	// MARK: Setup CollectionView Controller Constraints
	/// Configures `collectionView` constraints on view.
	private func setupCollectionViewConstraints() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	// MARK: Register Cells
	/// Registering cells of `collectionView`.
	private func registerCell() {
		collectionView.register(DogsCollectionViewCell.self, forCellWithReuseIdentifier: DogsCollectionViewCell.id)
	}
	
	// MARK: Alert
	/// Sends an alert when user touches the right button of navigation.
	private func addLogoutAlert() {
		let alert = UIAlertController(title: "Confirmar saída", message: "Tem certeza que deseja sair do applicativo?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: { _ in
		}))
		alert.addAction(UIAlertAction(title: "Sair", style: UIAlertAction.Style.destructive, handler: { _ in
			self.dismiss(animated: true, completion: nil)
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	// MARK: @objc
	@objc func askingLogout() {
		addLogoutAlert()
	}
}

// MARK: UICollectionViewDataSource
extension DogsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogsCollectionViewCell.id, for: indexPath) as? DogsCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.setImage(name: viewModel.images[indexPath.item])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		coordinator.specificDog(name: viewModel.images[indexPath.item], nav: self.navigationController!)
	}
}

// MARK: UICollectionViewDelegateFlowLayout
extension DogsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if UIDevice.current.orientation.isLandscape {
			return CGSize(width: collectionView.frame.size.width * 0.5, height:(self.view.frame.height) * 0.7)
		}
		
		return CGSize(width: collectionView.frame.size.width * 0.5, height:(self.view.frame.height) * 0.35)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

