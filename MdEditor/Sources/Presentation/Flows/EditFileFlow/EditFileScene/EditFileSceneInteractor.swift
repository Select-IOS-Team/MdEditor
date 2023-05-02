//
//  EditFileSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import Foundation

/// Интерактор сцены редактирования файла.
protocol IEditFileSceneInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
}

/// Интерактор сцены редактирования файла.
final class EditFileSceneInteractor: IEditFileSceneInteractor {

	// MARK: - Private properties

	private let presenter: IEditFileScenePresenter
	private let coordinator: IEditFileCoordinator
	private let file: DirectoryObject

	// MARK: - Lificycle

	init(
		presenter: IEditFileScenePresenter,
		coordinator: IEditFileCoordinator,
		file: DirectoryObject
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.file = file
	}

	deinit {
		coordinator.didCloseEditFileScene()
	}

	// MARK: - IEditFileSceneInteractor

	func fetchData() {
		guard let text = file.getFileText() else { return }

		let response = EditFileSceneModel.Response(text: text)
		presenter.presentData(response: response)
	}
}
