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
	private let markdownTextParser: IMarkdownTextParser

	// MARK: - Lificycle

	init(
		presenter: IEditFileScenePresenter,
		coordinator: IEditFileCoordinator,
		file: DirectoryObject,
		markdownTextParser: IMarkdownTextParser
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.file = file
		self.markdownTextParser = markdownTextParser
	}

	deinit {
		coordinator.didCloseEditFileScene()
	}

	// MARK: - IEditFileSceneInteractor

	func fetchData() {
		guard let text = file.getFileText() else { return }

		let attributedText = markdownTextParser.parse(text)
		let response = EditFileSceneModel.Response(attributedText: attributedText)
		presenter.presentData(response: response)
	}
}
