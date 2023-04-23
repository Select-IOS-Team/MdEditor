//
//  AboutSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Сборщик сцены информации о приложении
enum AboutSceneAssembly {
	static func assemble() -> AboutSceneViewController {
		let fileExplorerManager = FileExplorerManager()
		let convertToResponseWorker = AboutSceneWorker()
		let presenter = AboutScenePresenter()
		let interactor = AboutSceneInteractor(
			presenter: presenter,
			fileExplorerManager: fileExplorerManager,
			convertToResponseWorker: convertToResponseWorker
		)
		let viewController = AboutSceneViewController(interactor: interactor)

		presenter.viewController = viewController

		return viewController
	}
}