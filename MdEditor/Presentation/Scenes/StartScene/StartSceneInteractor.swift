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
	/// Выполняет навигацию в зависимости от выбора элемента в меню
	func handleSelectedMenuItem(menuType: StartSceneModel.ViewData.MenuItemType)
}

/// Интерактор стартовой сцены.
final class StartSceneInteractor: IStartSceneInteractor {

	// MARK: - Private properties

	private let presenter: IStartScenePresenter
	private let fileExplorerManager: IFileExplorerManager
	private let appCoordinator: IAppCoordinator

	// MARK: - Lificycle

	init(
		presenter: IStartScenePresenter,
		fileExplorerManager: IFileExplorerManager,
		appCoordinator: IAppCoordinator
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
		self.appCoordinator = appCoordinator
	}

	// MARK: - IStartSceneInteractor

	func fetchData() {
		let response = StartSceneModel.Response { [weak self] fileName in
			guard let self = self,
				  let defaultDirectoryURL = self.fileExplorerManager.defaultDirectoryURL else { return }

			self.fileExplorerManager.createFile(
				in: defaultDirectoryURL,
				fileName: fileName,
				fileExtension: StringConstants.mdExtension,
				withContent: ""
			)
		}
		presenter.presentData(response: response)
	}

	func handleSelectedMenuItem(menuType: StartSceneModel.ViewData.MenuItemType) {

		switch menuType {
		case .createDocument(let createAction):
			appCoordinator.mainFlowOption = .createDocument(createAction: createAction)
		case .openDirectoryObject:
			appCoordinator.mainFlowOption = .openDirectoryObject
		case .aboutApp:
			appCoordinator.mainFlowOption = .aboutApp
		}

		appCoordinator.start()
	}
}
