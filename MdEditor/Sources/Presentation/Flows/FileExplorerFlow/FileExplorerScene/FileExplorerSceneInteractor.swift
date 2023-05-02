//
//  FileExplorerSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор сцены файлового менеджера.
protocol IFileExplorerSceneInteractor: AnyObject {
	/// Получает объекты директории.
	func fetchDirectoryObjects()
	/// Уведомляет о выборе объекта в директории.
	/// - Parameter index: Индекс объекта в списке.
	func didChooseDirectoryObject(at index: Int)
}

/// Интерактор сцены файлового менеджера.
final class FileExplorerSceneInteractor: IFileExplorerSceneInteractor {

	// MARK: - Private properties

	private let presenter: IFileExplorerScenePresenter
	private let coordinator: IFileExplorerCoordinator
	private let fileExplorerManager: IFileExplorerManager
	private let directoryPath: String
	private var directoryObjects = [DirectoryObject]()

	// MARK: - Lifecycle

	init(
		presenter: IFileExplorerScenePresenter,
		coordinator: IFileExplorerCoordinator,
		fileExplorerManager: IFileExplorerManager,
		directoryPath: String
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.fileExplorerManager = fileExplorerManager
		self.directoryPath = directoryPath
	}

	deinit {
		coordinator.didCloseFileExplorerSceneScene()
	}

	// MARK: - IFileExplorerSceneInteractor

	func fetchDirectoryObjects() {
		directoryObjects = fileExplorerManager.fillDirectoryObjects(path: directoryPath)
		let response = FileExplorerSceneModel.Response(directoryPath: directoryPath, directoryObjects: directoryObjects)
		presenter.presentData(response: response)
	}

	func didChooseDirectoryObject(at index: Int) {
		guard index < directoryObjects.count else { return }
		let object = directoryObjects[index]

		if object.isFolder {
			coordinator.openDirectory(path: object.path)
		} else {
			coordinator.openFile(object)
		}
	}
}
