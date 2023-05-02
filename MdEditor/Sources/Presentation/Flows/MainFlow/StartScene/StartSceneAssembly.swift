//
//  StartSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Сборщик стартовой сцены.
enum StartSceneAssembly {

	static func assemble(coordinator: IAppCoordinator) -> StartSceneViewController {
		let presenter = StartScenePresenter()
		let fileExplorerManager = FileExplorerManager()
		let interactor = StartSceneInteractor(
			presenter: presenter,
			coordinator: coordinator,
			fileExplorerManager: fileExplorerManager
		)
		let viewController = StartSceneViewController(interactor: interactor)

		presenter.viewController = viewController

		return viewController
	}
}
