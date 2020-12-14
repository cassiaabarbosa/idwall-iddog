//
//  DogCoordinator.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

class DogCoordinator {
	
	func start(haveToken: Bool) -> UIViewController {
		if haveToken {
			return CustomUITabBarController(coordinator: self)
		}
		return LoginViewController(viewModel: LoginViewModel())
	}
	
	func loadTabController(viewController: UIViewController) {
		let tabBarController = CustomUITabBarController(coordinator: self)
		viewController.present(tabBarController, animated: true, completion: nil)
	}
	
	func specificDog(name: String, nav: UINavigationController) {
		let vm = SpecificDogViewModel(name: name)
		let vc = SpecificDogViewController(viewModel: vm)
		nav.pushViewController(vc, animated: true)
	}
}
