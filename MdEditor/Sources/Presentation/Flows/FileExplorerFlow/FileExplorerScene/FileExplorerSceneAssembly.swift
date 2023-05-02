//
//  FileExplorerSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Сборщик сцены файлового менеджера.
enum FileExplorerSceneAssembly {

	static func assemble(coordinator: IFileExplorerCoordinator, directoryPath: String) -> FileExplorerSceneViewController {
		let presenter = FileExplorerScenePresenter()
		let fileExplorerManager = FileExplorerManager()
		let interactor = FileExplorerSceneInteractor(
			presenter: presenter,
			coordinator: coordinator,
			fileExplorerManager: fileExplorerManager,
			directoryPath: directoryPath
		)
		let viewController = FileExplorerSceneViewController(interactor: interactor)
		presenter.viewController = viewController

		return viewController
	}
}
