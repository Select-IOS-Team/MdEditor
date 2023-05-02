//
//  EditFileSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import Foundation

/// Сборщик сцены редактирования файла.
enum EditFileSceneAssembly {

	static func assemble(coordinator: IEditFileCoordinator, file: DirectoryObject) -> EditFileSceneViewController {
		let presenter = EditFileScenePresenter()
		let interactor = EditFileSceneInteractor(
			presenter: presenter,
			coordinator: coordinator,
			file: file
		)
		let viewController = EditFileSceneViewController(interactor: interactor)

		presenter.viewController = viewController
		return viewController
	}
}
