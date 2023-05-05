//
//  FileExplorerCoordinator.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 27.04.2023.
//

import UIKit

protocol IFileExplorerCoordinator: ICoordinator {
	/// Открывает директорию.
	/// - Parameter path: Путь директории.
	func openDirectory(path: String)
	/// Открывает файл.
	/// - Parameter file: Модель `DirectoryObject` открываемого файл.
	func openFile(_ file: DirectoryObject)
	/// Уведомляет о закрытии сцены файлового менеджера.
	func didCloseFileExplorerSceneScene()
}

final class FileExplorerCoordinator: IFileExplorerCoordinator {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Private properties

	private var childViewControllerCount = 0

	// MARK: - Lifecycle

	init(navigationController: UINavigationController, finishDelegate: ICoordinatorFinishDelegate?) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
	}

	// MARK: - ICoordinator

	func start() {
		let fileExplorerViewController = FileExplorerSceneAssembly.assemble(
			coordinator: self,
			directoryPath: StringConstants.root
		)
		navigationController.show(fileExplorerViewController, sender: nil)
		childViewControllerCount += 1
	}

	// MARK: - IFileExplorerSceneCoordinator

	func openDirectory(path: String) {
		let fileExplorerViewController = FileExplorerSceneAssembly.assemble(coordinator: self, directoryPath: path)
		navigationController.show(fileExplorerViewController, sender: nil)
		childViewControllerCount += 1
	}

	func openFile(_ file: DirectoryObject) {
//		let editFileCoordinator = EditFileCoordinator(
//			navigationController: navigationController,
//			finishDelegate: self,
//			file: file
//		)
		let editFileCoordinator = BrowseHTMLCoordinator(
			navigationController: navigationController,
			finishDelegate: self,
			file: file
		)
		childCoordinators.append(editFileCoordinator)
		editFileCoordinator.start()
		childViewControllerCount += 1
	}

	func didCloseFileExplorerSceneScene() {
		childViewControllerCount -= 1
		if childViewControllerCount == 0 {
			finish()
		}
	}
}

// MARK: - ICoordinatorFinishDelegate

extension FileExplorerCoordinator: ICoordinatorFinishDelegate {

	func didFinish(coordinator: ICoordinator) {
		childCoordinators.removeAll { $0 === coordinator }
		childViewControllerCount -= 1
	}
}
