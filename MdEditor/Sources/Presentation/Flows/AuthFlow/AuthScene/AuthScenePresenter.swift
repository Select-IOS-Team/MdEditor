//
//  AuthScenePresenter.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Презентер сцены авторизации.
protocol IAuthScenePresenter {
	/// Подготавливает презентационные данные для вью.
	/// - Parameter response: Модель данных ответа интерактора на запрос авторизации.
	func present(response: AuthSceneModels.Response)
}

/// Презентер сцены авторизации.
final class AuthScenePresenter: IAuthScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IAuthViewController?

	// MARK: - IAuthPresenter

	func present(response: AuthSceneModels.Response) {
		let viewModel = AuthSceneModels.ViewModel(
			success: response.success,
			userName: response.login
		)
		viewController?.render(viewModel: viewModel)
	}
}
