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
	/// Выполняет навигацию
	func coordinate(menuType: StartSceneModel.ViewData.MenuItemType)
}

/// Интерактор стартовой сцены.
final class StartSceneInteractor: IStartSceneInteractor {

	// MARK: - Private properties

	private let presenter: IStartScenePresenter
	private let fileExplorerManager: IFileExplorerManager
	private let coordinator: IMainCoordinator

	// MARK: - Lificycle

	init(
		presenter: IStartScenePresenter,
		fileExplorerManager: IFileExplorerManager,
		coordinator: IMainCoordinator
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
		self.coordinator = coordinator
	}

	// MARK: - IStartSceneInteractor

	func fetchData() {
		let response = StartSceneModel.Response { [weak self] fileName in
			guard let self = self,
				  let documentDirectoryURL = self.fileExplorerManager.documentDirectoryURL else { return }

			self.fileExplorerManager.createFile(
				in: documentDirectoryURL,
				fileName: fileName,
				fileExtension: StringConstants.mdExtension,
				withContent: ""
			)
		}
		presenter.presentData(response: response)
	}

	func coordinate(menuType: StartSceneModel.ViewData.MenuItemType) {

		switch menuType {
		case .new(let createAction):
			coordinator.mainFlowType = .new(createAction: createAction)
		case .open:
			coordinator.mainFlowType = .open
		case .about:
			coordinator.mainFlowType = .about
		}

		coordinator.start()
	}
}
