//
//  AboutAppSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Сборщик сцены информации о приложении.
enum AboutAppSceneAssembly {

	static func assemble() -> AboutAppSceneViewController {
		let fileExplorerManager = FileExplorerManager()
		let presenter = AboutAppScenePresenter()
		let interactor = AboutAppSceneInteractor(presenter: presenter, fileExplorerManager: fileExplorerManager)
		let viewController = AboutAppSceneViewController(interactor: interactor)

		presenter.viewController = viewController
		return viewController
	}
}
