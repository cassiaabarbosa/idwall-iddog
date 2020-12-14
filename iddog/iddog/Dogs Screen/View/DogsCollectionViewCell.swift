//
//  DogsCollectionViewCell.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit
/// The cell of `collectionView` present on `DogsViewController`.
class DogsCollectionViewCell: UICollectionViewCell {
	// MARK: Properties
	@TemplateView var dog: UIImageView
	
	static var id: String {
		return String(describing: self)
	}
	
	// MARK: init()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupDogAttributes()
		setupDogConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Setup `dog` component.
	/// Configures `dog` constraints on view.
	private func setupDogConstraints() {
		NSLayoutConstraint.activate([
			dog.topAnchor.constraint(equalTo: self.topAnchor),
			dog.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			dog.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			dog.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		])
	}
	
	/// Configures `dog` atributes, such as the scale type and background color.
	private func setupDogAttributes() {
		addSubview(dog)
		dog.contentMode = .scaleAspectFill
		dog.backgroundColor = .systemGray6
		dog.layer.masksToBounds = true
	}
	
	/// Configures what image name is in the cell.
	func setImage(name: String) {
		self.dog.image = UIImage(named: name)
	}
}

