//
//  AuthSceneViewController.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit
import SnapKit

/// Вью контроллер сцены авторизации.
protocol IAuthViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewModel: AuthSceneModels.ViewModel)
}

/// Вью контроллер сцены авторизации.
final class AuthSceneViewController: UIViewController {

	// MARK: - Nested types

	private enum Constants {
		static let loginTextFieldPlaceholder = L10n.AuthScene.loginTextFieldPlaceholder
		static let passwordTextFieldPlaceholder = L10n.AuthScene.passwordTextFieldPlaceholder
		static let signInButtonTitle = L10n.AuthScene.signInButtonTitle
		static let signInButtonCornerRadius: CGFloat = 6
		static let textFieldSize = CGSize(width: 250, height: 40)
		static let loginButtonSize = CGSize(width: 100, height: 40)
		static let betweenTextFieldsSpace: CGFloat = 27
		static let loginButtonTopSpace: CGFloat = 64
	}

	// MARK: - Private properties

	private let interactor: IAuthSceneInteractor

	private lazy var loginTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Constants.loginTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .username
		return textField
	}()
	private lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Constants.passwordTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		return textField
	}()
	private lazy var loginButton: UIButton = {
		let button = UIButton()
		button.setTitle(Constants.signInButtonTitle, for: .normal)
		button.backgroundColor = Palette.main
		button.layer.cornerRadius = Constants.signInButtonCornerRadius
		button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
		return button
	}()

	// MARK: - Lifecycle

	init(interactor: IAuthSceneInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
	}

	// MARK: - Private methods

	@objc
	private func didTapLoginButton(_ sender: UIButton) {
		guard let login = loginTextField.text,
			  let password = passwordTextField.text else { return }
		let request = AuthSceneModels.Request(login: login, password: password)
		interactor.loginButtonTapped(request: request)
	}

	func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		let action = UIAlertAction(title: L10n.AuthScene.AlertActions.ok, style: .default, handler: completion)
		alert.addAction(action)
		present(alert, animated: true)
	}

	func setupUI() {
		view.backgroundColor = Palette.background
		view.addSubview(loginTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
	}

	func setupLayout() {
		view.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}

		loginTextField.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.size.equalTo(Constants.textFieldSize)
			$0.centerX.equalToSuperview()
		}

		passwordTextField.snp.makeConstraints {
			$0.size.equalTo(Constants.textFieldSize)
			$0.top.equalTo(loginTextField.snp.bottom).offset(Constants.betweenTextFieldsSpace)
			$0.centerX.equalToSuperview()
		}

		loginButton.snp.makeConstraints {
			$0.size.equalTo(Constants.loginButtonSize)
			$0.top.equalTo(passwordTextField.snp.bottom).offset(Constants.loginButtonTopSpace)
			$0.centerX.equalToSuperview()
		}
	}
}

// MARK: - IAuthViewController

extension AuthSceneViewController: IAuthViewController {
	public func render(viewModel: AuthSceneModels.ViewModel) {
		if !viewModel.success {
			showAlert(title: L10n.AuthScene.AlertActions.error, message: "")
		}
	}
}
