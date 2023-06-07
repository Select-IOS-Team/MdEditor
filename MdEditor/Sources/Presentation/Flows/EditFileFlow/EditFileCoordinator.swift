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
	/// Открывает документ в формате pdf в новом окне.
	/// - Parameter file: Принимает файл для откыртия.
	func openPdf(_ file: DirectoryObject)
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

	/// Открывает документ в формате pdf в новом окне.
	/// - Parameter file: Принимает файл для откыртия.
	func openPdf(_ file: DirectoryObject) {
		let browsePdfCoordinator = BrowsePDFCoordinator(
			navigationController: navigationController,
			finishDelegate: finishDelegate,
			file: file
		)
		childCoordinators.append(browsePdfCoordinator)
		browsePdfCoordinator.start()
	}

	// MARK: - IEditFileCoordinator

	func didCloseEditFileScene() {
		finish()
	}
}
