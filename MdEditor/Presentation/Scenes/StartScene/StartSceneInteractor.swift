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
	func coordinate(startSceneCoordinator: IMainCoordinator)
}

/// Интерактор стартовой сцены.
final class StartSceneInteractor: IStartSceneInteractor {

	// MARK: - Private properties

	private let presenter: IStartScenePresenter
	private let fileExplorerManager: IFileExplorerManager

	// MARK: - Lificycle

	init(
		presenter: IStartScenePresenter,
		fileExplorerManager: IFileExplorerManager
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
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

	func coordinate(startSceneCoordinator: IMainCoordinator) {
		startSceneCoordinator.start()
	}
}
