//
//  EditFileCoordinator.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import UIKit

protocol IEditFileCoordinator: ICoordinator {
	/// Уведомляет о закрытии сцены редактирования файла.
	func didCloseEditFileScene()
}

final class EditFileCoordinator: IEditFileCoordinator {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Private properties

	private let file: DirectoryObject

	// MARK: - Lifecycle

	init(
		navigationController: UINavigationController,
		finishDelegate: ICoordinatorFinishDelegate?,
		file: DirectoryObject
	) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
		self.file = file
	}

	// MARK: - ICoordinator

	func start() {
		let editFileViewController = EditFileSceneAssembly.assemble(coordinator: self, file: file)
		navigationController.show(editFileViewController, sender: nil)
	}

	// MARK: - IEditFileCoordinator

	func didCloseEditFileScene() {
		finish()
	}
}
