//
//  AuthSceneAssembly.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Сборщик сцены авторизации.
enum AuthSceneAssembly {

	static func assemble(coordinator: IAuthCoordinator) -> AuthSceneViewController {
		let presenter = AuthScenePresenter()

		let interactor = AuthSceneInteractor(
			worker: AuthSceneWorker(),
			presenter: presenter,
			coordinator: coordinator
		)
		let viewController = AuthSceneViewController(interactor: interactor)

		presenter.viewController = viewController
		return viewController
	}
}
