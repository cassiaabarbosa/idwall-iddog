//
//  SpecificDogViewController.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

/// Class created to show an specific dog image.
final class SpecificDogViewController: UIViewController {
	// Properties
	@TemplateView var dog: UIImageView
	
	private var viewModel: SpecificDogViewModel
	
	// MARK: init()
	init(viewModel: SpecificDogViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		view.backgroundColor = .systemGray6
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: life cicle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupDogAttributes()
		setupDogConstraints()
		setupImageName()
		
	}
	
	private func setupDogAttributes() {
		view.addSubview(dog)
		dog.contentMode = .scaleAspectFill
	}
	
	// MARK: Constraints
	private func setupDogConstraints() {
		NSLayoutConstraint.activate([
			dog.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			dog.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			dog.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			dog.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
		])
	}
	
	private func setupImageName() {
		dog.contentMode = .scaleToFill
		dog.image = UIImage(named: viewModel.name)
	}
}

