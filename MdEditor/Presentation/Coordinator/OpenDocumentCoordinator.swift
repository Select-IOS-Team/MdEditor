//
//  OpenDocumentCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

// Виды объектов открываемых координатором
enum OpenCoordinatorObjectType {
	case document
	case folder
}

/// Координатор сцен открытия объектов (файлов/каталогов)
protocol IOpenDocumentCoordinator: ICoordinator {
	var currentPath: String { get set }
	var mainFlowType: MainFlowType? { get set }
	var objectType: OpenCoordinatorObjectType? { get set }
	func showOpenDocumentScene()
	func showAboutScene()
	func showNewFileScene(createAction: @escaping (String) -> Void)
}

/// Координатор сцен открытия объектов (файлов/каталогов)
final class OpenDocumentCoordinator: IOpenDocumentCoordinator {

	// MARK: Internal properties

	var currentPath: String
	var mainFlowType: MainFlowType?
	var objectType: OpenCoordinatorObjectType? = .folder
	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lificycle

	init(currentPath: String, navigationController: UINavigationController) {
		self.currentPath = currentPath
		self.navigationController = navigationController
	}

	// MARK: IOpenDocumentCoordinator

	func showOpenDocumentScene() {

		switch self.objectType {
		case .folder:
			let openDocumentViewController = OpenDocumentAssembly.assemble(
				currentPath: currentPath,
				navigationController: navigationController
			)
			navigationController.pushViewController(openDocumentViewController, animated: true)
		case .document:
			return
		case .none:
			fatalError("Ошибка. Не передано обязательное значение objectType")
		}
	}

	func showAboutScene() {
		let aboutViewController = AboutSceneAssembly.assemble()
		navigationController.pushViewController(aboutViewController, animated: true)
	}

	func showNewFileScene(createAction: @escaping (String) -> Void) {
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

		navigationController.present(alertController, animated: true)
	}

	// MARK: ICoordinator

	func start() {
		switch self.mainFlowType {
		case .new(let createAction):
			showNewFileScene(createAction: createAction)
		case .open:
			showOpenDocumentScene()
		case .about:
			showAboutScene()
		case .none:
			fatalError("Ошибка. Не передано обязательное значение mainFlowType")
		}
	}
}
