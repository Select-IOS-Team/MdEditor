//
//  StartSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор стартовой сцены.
protocol IStartSceneInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
	/// Уведомляет о нажатии недавнего файла.
	func didTapRecentFile()
	/// Уведомляет о нажатии пункта меню.
	/// - Parameter menuItem: Тип пункта меню.
	func didTapMenuItem(_ menuItem: StartSceneModel.MenuItemType)
}

/// Интерактор стартовой сцены.
final class StartSceneInteractor: IStartSceneInteractor {

	// MARK: - Private properties

	private let presenter: IStartScenePresenter
	private var coordinator: IStartCoordinator
	private let fileExplorerManager: IFileExplorerManager

	// MARK: - Lificycle

	init(
		presenter: IStartScenePresenter,
		coordinator: IStartCoordinator,
		fileExplorerManager: IFileExplorerManager
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.fileExplorerManager = fileExplorerManager
	}

	// MARK: - IStartSceneInteractor

	func fetchData() {
		let response = StartSceneModel.Response(createFileAction: { [weak self] fileName in
			// Временно создание файла реализовано в катологе Documents
			guard let self = self,
				  let documentDirectoryURL = self.fileExplorerManager.documentDirectoryURL else { return }

			self.fileExplorerManager.createFile(
				in: documentDirectoryURL,
				fileName: fileName,
				fileExtension: StringConstants.mdExtension,
				withContent: ""
			)
		})
		presenter.presentData(response: response)
	}

	func didTapRecentFile() {}

	func didTapMenuItem(_ menuItem: StartSceneModel.MenuItemType) {
		switch menuItem {
		case .newFile(let createAction):
			coordinator.showNewFileAlertController(createAction: createAction)
		case .openFile:
			coordinator.showFileExplorerFlow()
		case .aboutApp:
			coordinator.showAboutAppScene()
		}
	}
}
