//
//  StartSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Сборщик стартовой сцены.
enum StartSceneAssembly {

	static func assemble() -> StartSceneViewController {
		let presenter = StartScenePresenter()
		let interactor = StartSceneInteractor(presenter: presenter)
		let router = StartSceneRouter()
		let viewController = StartSceneViewController(interactor: interactor, router: router)

		presenter.viewController = viewController
		router.viewController = viewController

		return viewController
	}
}