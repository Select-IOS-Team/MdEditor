//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 27.04.2023.
//

import UIKit

protocol IAppCoordinator: ICoordinator {
	/// Показывает сцену редактирования файла.
	func showEditFileScene()
	/// Показывает AlertController создания нового файла.
	/// - Parameters:
	///   - createAction: Действие, обрабатывающее создание файла.
	func showNewFileAlertController(createAction: @escaping (String) -> Void)
	/// Запускает flow файлового менеджера.
	func showFileExplorerFlow()
	/// Показывает сцену О приложении.
	func showAboutAppScene()
}

final class AppCoordinator: IAppCoordinator, ICoordinatorFinishDelegate {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Lifecycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - ICoordinator

	func start() {
		let startViewController = StartSceneAssembly.assemble(coordinator: self)
		navigationController.show(startViewController, sender: nil)
	}

	// MARK: - IAppCoordinator

	func showEditFileScene() {
		// Бедет реализовано позже
	}

	func showNewFileAlertController(createAction: @escaping (String) -> Void) {
		let alertController = UIAlertController(
			title: L10n.StartScene.NewFileAlert.title,
			message: "",
			preferredStyle: .alert
		)
		let createAction = UIAlertAction(title: L10n.AlertController.Action.Create.title, style: .default) { _ in
			guard let textField = alertController.textFields?.first,
				  let fileName = textField.text else { return }
			createAction(fileName)
		}
		let cancelAction = UIAlertAction(title: L10n.AlertController.Action.Cancel.title, style: .cancel)

		alertController.addTextField { textField in
			textField.placeholder = L10n.StartScene.NewFileAlert.TextField.placeholder
		}
		alertController.addAction(createAction)
		alertController.addAction(cancelAction)

		navigationController.present(alertController, animated: false)
	}

	func showFileExplorerFlow() {
		let fileExplorerCoordinator = FileExplorerCoordinator(
			navigationController: navigationController,
			finishDelegate: self
		)
		childCoordinators.append(fileExplorerCoordinator)
		fileExplorerCoordinator.start()
	}

	func showAboutAppScene() {
		let aboutAppViewController = AboutAppSceneAssembly.assemble()
		navigationController.show(aboutAppViewController, sender: nil)
	}
}
