//
//  CustomUITabBarController.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

/// Class created to handle with a custom UITabBarController.
class CustomUITabBarController: UITabBarController {
	
	// MARK: Properties
	private var huskyViewController: UINavigationController
	private let houndViewController: UINavigationController
	private let labradorViewController: UINavigationController
	private let pugViewController: UINavigationController
	
	// MARK: init()
	init(coordinator: DogCoordinator) {
		self.huskyViewController = UINavigationController(rootViewController: DogsViewController(viewModel: DogsViewModel(), coordinator: coordinator))
		self.houndViewController = UINavigationController(rootViewController: DogsViewController(viewModel: DogsViewModel(), coordinator: coordinator))
		self.labradorViewController = UINavigationController(rootViewController: DogsViewController(viewModel: DogsViewModel(), coordinator: coordinator))
		self.pugViewController = UINavigationController(rootViewController: DogsViewController(viewModel: DogsViewModel(), coordinator: coordinator))
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupBar()
		self.modalPresentationStyle = .fullScreen
	}
	
	// MARK: Set up TabBar
	/// Configures `UITabBar` attributes, such as which view controller it is responsible for and, the color when a item is select.
	private func setupBar() {
		huskyViewController.tabBarItem = UITabBarItem(title: "Husky", image:UIImage(named: "husky"), tag: 0)
		houndViewController.tabBarItem = UITabBarItem(title: "Hound", image:UIImage(named: "hound"), tag: 1)
		labradorViewController.tabBarItem = UITabBarItem(title: "Labrador", image:UIImage(named: "labrador"), tag: 2)
		pugViewController.tabBarItem = UITabBarItem(title: "Pug", image:UIImage(named: "pug"), tag: 3)
		self.viewControllers = [huskyViewController, houndViewController, labradorViewController, pugViewController]
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.accent],for: .selected)
		UITabBar.appearance().tintColor = UIColor.accent
	}
}
