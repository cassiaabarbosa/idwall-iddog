//
//  LoginViewController.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

/// Class created to shows the Login Screen. It is the first screen when user has not a saved token in application for his email.
final class LoginViewController: UIViewController {
	
	// MARK: Properties
	@TemplateView var base: UIView
	
	@TemplateView var background: UIView
	
	@TemplateView var name: UILabel
	
	@TemplateView var credential: UITextField
	
	@TemplateView var login: UIButton
	
	var changedConstraints : [[NSLayoutConstraint]]
	
	let activityView = UIActivityIndicatorView(style: .large)
	
	private var viewModel: LoginViewModel
	
	let coordinator: DogCoordinator

	// MARK: init
	init(viewModel: LoginViewModel) {
		self.viewModel = viewModel
		self.changedConstraints = [[]]
		self.coordinator = DogCoordinator()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
		
		addSubviews()
		
		setupNameAttributes()
		setupNameConstraints()
		
		setupViewAttributes()
		setupBaseConstraints()
		
		setupBackgroundAttributes()
		setupBackgroundConstraints()
		
		setupCredentialAttributes()
		
		setupLoginAttributes()
		
		changedConstraints = [setupCredentialPortraitConstraints(), setupCredentialLandscapeConstraints(), setupLoginPortraitConstraints(),setupLoginLandscapeConstraints()]
		
		activityViewConstraints()
	}
	
	// MARK: viewWillLayoutSubviews()
	/// This function is called when device orientation is changed. To provide a better user experience, the constraints of `credential` `UITextfField` and `login` `UIBUtton` are activated ou deactived when device is on portrait or landscape orientation.
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
	
	// MARK: addSubviews()
	/// This function adds all created subviews to respective views.
	private func addSubviews() {
		view.addSubview(base)
		view.addSubview(background)
		view.addSubview(activityView)
		view.addSubview(name)
		background.addSubview(credential)
		background.addSubview(login)
	}
	
	// MARK: setting up `name` component
	/// This function configures the `name` attributes, such as its text, text color and fonte type.
	private func setupNameAttributes() {
		name.text = "IDDOG"
		name.font = UIFont.boldSystemFont(ofSize: 50)
		name.textColor = .white
	}
	
	/// This function configures `name` constraints on view.
	private func setupNameConstraints() {
		NSLayoutConstraint.activate([
			name.centerYAnchor.constraint(equalTo: self.base.centerYAnchor),
			name.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			name.heightAnchor.constraint(equalToConstant: 100)
		])
	}
	
	// MARK: setting up `View`
	/// This function configures the base `view` background color.
	private func setupViewAttributes() {
		self.view.backgroundColor = .accent
	}
	
	/// This function configures `base` constraints on view.
	private func setupBaseConstraints() {
		NSLayoutConstraint.activate([
			base.topAnchor.constraint(equalTo: self.view.topAnchor),
			base.bottomAnchor.constraint(equalTo: background.topAnchor, constant: 40),
			base.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			base.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
		])
	}
	
	// MARK: setting up `background` component
	/// This function configures `background` attributes, such as its background and shadow color, cornes radius and shadow length.
	private func setupBackgroundAttributes() {
		background.backgroundColor = .systemGray6
		background.layer.shadowColor = UIColor.black.cgColor
		background.layer.shadowOffset = .zero
		background.layer.shadowRadius = 4
		background.layer.shadowOpacity = 0.3
		background.layer.cornerRadius = 20
		background.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		background.clipsToBounds = false
	}
	
	/// This function configures `background` constraints on view.
	private func setupBackgroundConstraints() {
		NSLayoutConstraint.activate([
			background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			background.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45)
		])
	}
	
	// MARK: setting up `credential` component
	/// This function configures `credential` attributes, such as its background color, placeholder, keyboard and return types, correction, border and text alignment.
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
	
	/// This function configures `credential` constraints on portrait orientation.
	/// - return: `[NSLayoutConstraint]`
	private func setupCredentialPortraitConstraints()  -> [NSLayoutConstraint]{
		return [
			credential.topAnchor.constraint(equalTo: background.topAnchor, constant: view.frame.size.height * 0.05),
			credential.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			credential.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			credential.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
		]
	}
	
	/// This function configures `credential` constraints on landscape orientation.
	/// - return: `[NSLayoutConstraint]`
	private func setupCredentialLandscapeConstraints()-> [NSLayoutConstraint]  {
		return [
			credential.topAnchor.constraint(equalTo: background.topAnchor, constant: view.frame.size.height * 0.05),
			credential.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width * 0.2 ),
			credential.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width * 0.2 ),
			credential.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)]
	}
	
	// MARK: setting up `login` component
	/// This function configures `login` attributes, such as its title and background color. Also adds a target.
	private func setupLoginAttributes() {
		login.layer.cornerRadius = 20
		login.setTitle("ENTRAR", for: .normal)
		login.backgroundColor = UIColor(red: 90/255, green: 16/255, blue: 236/255, alpha: 1.0)
		login.addTarget(self, action: #selector(signIn), for: .touchUpInside)
	}
	
	/// This function configures `login` constraints on portrait orientation.
	/// - return: `[NSLayoutConstraint]`
	private func setupLoginPortraitConstraints()  -> [NSLayoutConstraint]{
		return [
			login.topAnchor.constraint(equalTo: credential.bottomAnchor, constant: view.frame.size.height * 0.1),
			login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			login.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
		]
	}
	
	/// This function configures `login` constraints on landscape orientation.
	/// - return: `[NSLayoutConstraint]`
	private func setupLoginLandscapeConstraints()-> [NSLayoutConstraint]  {
		return [
			login.topAnchor.constraint(equalTo: credential.bottomAnchor, constant: view.frame.size.height * 0.03),
			login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width * 0.4 ),
			login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width * 0.4 ),
			login.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)]
	}
	
	// MARK: activityViewConstraints()
	/// This funcion configures `activityView` constraints on View.
	func activityViewConstraints() {
		self.activityView.center = view.center
	}
	
	// MARK: @objc
	/// This function is called when `login` button is pressed.
	@objc func signIn() {
		self.activityView.startAnimating()
		_ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
			self.activityView.stopAnimating()
		})
		
		viewModel.authenticateEmail()
	}
}

// MARK: LoginDelegate
extension LoginViewController: LoginDelegate {
	/// This function send an alert when user token cannot be authenticated.
	func erroringLoadDogs() {
		let alert = UIAlertController(title: "Erro", message: "Não foi possível autenticar o usuário. Tente novamente.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertAction.Style.default, handler: { _ in}))
		self.present(alert, animated: true, completion: nil)
	}
	
	/// This function send an alert when user token is authenticated.
	func loadDogsController() {
//		self.coordinator.start(viewController: self)
		print("bateu")
		
	}
}

