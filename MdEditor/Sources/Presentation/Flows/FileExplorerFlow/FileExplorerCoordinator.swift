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

	/// Количество открытых дочерних вью контроллеров. Необходимо для отслеживания необходимости финиша координатора.
	private var childViewControllerCount = 0

	// MARK: - Lifecycle

	init(navigationController: UINavigationController, finishDelegate: ICoordinatorFinishDelegate?) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
	}

	// MARK: - ICoordinator

	func start() {
		openDirectory(path: StringConstants.root)
	}

	// MARK: - IFileExplorerSceneCoordinator

	func openDirectory(path: String) {
		let fileExplorerViewController = FileExplorerSceneAssembly.assemble(coordinator: self, directoryPath: path)
		navigationController.show(fileExplorerViewController, sender: nil)
		childViewControllerCount += 1
	}

	func openFile(_ file: DirectoryObject) {
		startEditFileFlow(with: file)
	}

	func didCloseFileExplorerSceneScene() {
		childViewControllerCount -= 1
		if childViewControllerCount == 0 {
			finish()
		}
	}

	// MARK: - Private methods

	private func startEditFileFlow(with file: DirectoryObject) {
		let editFileCoordinator = EditFileCoordinator(
			navigationController: navigationController,
			finishDelegate: self,
			file: file
		)
		childCoordinators.append(editFileCoordinator)
		editFileCoordinator.start()
		childViewControllerCount += 1
	}

	private func startBrowseHTMLFlow(with file: DirectoryObject) {
		let browseHTMLCoordinator = BrowseHTMLCoordinator(
			navigationController: navigationController,
			finishDelegate: self,
			file: file
		)
		childCoordinators.append(browseHTMLCoordinator)
		browseHTMLCoordinator.start()
		childViewControllerCount += 1
	}
}

// MARK: - ICoordinatorFinishDelegate

extension FileExplorerCoordinator: ICoordinatorFinishDelegate {

	func didFinish(coordinator: ICoordinator) {
		childCoordinators.removeAll { $0 === coordinator }
		childViewControllerCount -= 1
	}
}
