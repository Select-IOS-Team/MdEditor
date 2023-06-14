//
//  AuthSceneInteractor.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Интерактор сцены авторизации.
protocol IAuthSceneInteractor {
	/// Метод нажатия на кнопку логина на экране авторизации.
	/// - Parameter request: Модель данных для выполнения запроса авторизации.
	func loginButtonTapped(request: AuthSceneModels.Request)
}

/// Интерактор сцены авторизации.
final class AuthSceneInteractor: IAuthSceneInteractor {

	// MARK: - Private properties

	private let worker: IAuthSceneWorker
	private let presenter: IAuthScenePresenter
	private let coordinator: IAuthCoordinator

	// MARK: - Lifecycle

	init(
		worker: IAuthSceneWorker,
		presenter: IAuthScenePresenter,
		coordinator: IAuthCoordinator
	) {
		self.worker = worker
		self.presenter = presenter
		self.coordinator = coordinator
	}

	// MARK: - IAuthInteractor

	func loginButtonTapped(request: AuthSceneModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let response = AuthSceneModels.Response(
			success: result.success == 1,
			login: result.login
		)
		presenter.present(response: response)
		if result.success == 1 {
			coordinator.showStartScene()
		}
	}
}
