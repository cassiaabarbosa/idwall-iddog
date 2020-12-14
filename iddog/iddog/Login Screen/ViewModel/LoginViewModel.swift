//
//  LoginViewModel.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

protocol LoginDelegate: AnyObject {
	func erroringLoadDogs()
	func loadDogsController()
}

struct LoginViewModel {
	
	weak var delegate: LoginDelegate?
	
//	func authenticateEmail(email: String) {
//		if email == "email@email.com" {
//			delegate?.loadDogsController()
//		}
//	}
	
	func authenticateEmail() {
		delegate?.loadDogsController()
	}
}
