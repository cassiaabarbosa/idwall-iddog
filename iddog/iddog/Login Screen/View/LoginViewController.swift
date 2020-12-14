//
//  LoginViewController.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

import UIKit

final class LoginViewController: UIViewController {
	
	@TemplateView var base: UIView
	
	@TemplateView var background: UIView
	
	@TemplateView var name: UILabel
	
	@TemplateView var credential: UITextField
	
	@TemplateView var login: UIButton
	
	var changedConstraints : [[NSLayoutConstraint]]
	
	let activityView = UIActivityIndicatorView(style: .large)
	
	private var viewModel: LoginViewModel
	
	let coordinator: DogCoordinator

	init(viewModel: LoginViewModel) {
		self.viewModel = viewModel
		self.changedConstraints = [[]]
		self.coordinator = DogCoordinator()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
		
		addSubviews()
		
		setupNameAttributes()
		setupNameConstraints()
		
		setupIconAttributes()
		setupIconConstraints()
		
		setupBackgroundAttributes()
		setupBackgroundConstraints()
		
		setupCredentialAttributes()
		
		setupLoginAttributes()
		
		changedConstraints = [setupCredentialPortraitConstraints(), setupCredentialLandscapeConstraints(), setupLoginPortraitConstraints(),setupLoginLandscapeConstraints()]
		
		activityViewConstraints()
	}
	
	override func viewWillLayoutSubviews() {
		if UIDevice.current.orientation.isLandscape{
			NSLayoutConstraint.deactivate(changedConstraints[0])
			NSLayoutConstraint.deactivate(changedConstraints[2])
			
			NSLayoutConstraint.activate(changedConstraints[1])
			NSLayoutConstraint.activate(changedConstraints[3])
		} else {
			NSLayoutConstraint.deactivate(changedConstraints[1])
			NSLayoutConstraint.deactivate(changedConstraints[3])
			
			NSLayoutConstraint.activate(changedConstraints[0])
			NSLayoutConstraint.activate(changedConstraints[2])
		}
	}
	
	private func addSubviews() {
		view.addSubview(base)
		base.addSubview(name)
		view.addSubview(background)
		view.addSubview(activityView)
		background.addSubview(credential)
		background.addSubview(login)
	}
	
	private func setupNameAttributes() {
		name.text = "IDDOG"
		name.font = UIFont.boldSystemFont(ofSize: 50)
		name.textColor = .white
	}
	
	private func setupNameConstraints() {
		NSLayoutConstraint.activate([
			name.centerYAnchor.constraint(equalTo: self.base.centerYAnchor),
			name.centerXAnchor.constraint(equalTo: self.base.centerXAnchor),
			name.heightAnchor.constraint(equalToConstant: 100)
		])
	}
	
	private func setupIconAttributes() {
		base.backgroundColor = .accent
		base.contentMode = .scaleAspectFill
		base.clipsToBounds = true
	}
	
	private func setupIconConstraints() {
		NSLayoutConstraint.activate([
			base.topAnchor.constraint(equalTo: self.view.topAnchor),
			base.bottomAnchor.constraint(equalTo: background.topAnchor, constant: 40),
			base.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			base.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
		])
	}
	
	private func setupBackgroundAttributes() {
		view.addSubview(background)
		background.backgroundColor = .systemGray6
		background.layer.shadowColor = UIColor.black.cgColor
		background.layer.shadowOffset = .zero
		background.layer.shadowRadius = 4
		background.layer.shadowOpacity = 0.3
		background.layer.cornerRadius = 20
		background.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		background.clipsToBounds = false
	}
	
	private func setupBackgroundConstraints() {
		NSLayoutConstraint.activate([
			background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			background.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45)
		])
	}
	
	private func setupCredentialAttributes() {
		credential.backgroundColor = .systemGray5
		credential.placeholder = "email@email.com"
		credential.keyboardType = UIKeyboardType.default
		credential.returnKeyType = UIReturnKeyType.done
		credential.autocorrectionType = UITextAutocorrectionType.no
		credential.font = UIFont.systemFont(ofSize: 14)
		credential.borderStyle = UITextField.BorderStyle.roundedRect
		credential.clearButtonMode = UITextField.ViewMode.whileEditing;
		credential.textAlignment = .center
	}
	
	private func setupCredentialPortraitConstraints()  -> [NSLayoutConstraint]{
		return [
			credential.topAnchor.constraint(equalTo: background.topAnchor, constant: view.frame.size.height * 0.05),
			credential.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			credential.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			credential.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
		]
	}
	
	private func setupCredentialLandscapeConstraints()-> [NSLayoutConstraint]  {
		return [
			credential.topAnchor.constraint(equalTo: background.topAnchor, constant: view.frame.size.height * 0.05),
			credential.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width * 0.2 ),
			credential.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width * 0.2 ),
			credential.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)]
	}
	
	
	private func setupLoginAttributes() {
		login.layer.cornerRadius = 20
		login.setTitle("ENTRAR", for: .normal)
		login.backgroundColor = UIColor(red: 90/255, green: 16/255, blue: 236/255, alpha: 1.0)
		login.addTarget(self, action: #selector(signIn), for: .touchUpInside)
	}
	
	private func setupLoginPortraitConstraints()  -> [NSLayoutConstraint]{
		return [
			login.topAnchor.constraint(equalTo: credential.bottomAnchor, constant: view.frame.size.height * 0.1),
			login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			login.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
		]
	}
	
	private func setupLoginLandscapeConstraints()-> [NSLayoutConstraint]  {
		return [
			login.topAnchor.constraint(equalTo: credential.bottomAnchor, constant: view.frame.size.height * 0.03),
			login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width * 0.3 ),
			login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width * 0.3 ),
			login.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)]
	}
	func activityViewConstraints() {
		self.activityView.center = view.center
	}
	
	@objc func signIn() {
		self.activityView.startAnimating()
		_ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
			self.activityView.stopAnimating()
		})
		
		viewModel.authenticateEmail()
	}
}

extension LoginViewController: LoginDelegate {
	func erroringLoadDogs() {
		let alert = UIAlertController(title: "Erro", message: "Não foi possível autenticar o usuário. Tente novamente.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertAction.Style.default, handler: { _ in}))
		self.present(alert, animated: true, completion: nil)
	}
	
	func loadDogsController() {
		self.coordinator.start(viewController: self)
		
	}
}

