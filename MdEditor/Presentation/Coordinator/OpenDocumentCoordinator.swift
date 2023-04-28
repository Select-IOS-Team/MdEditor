//
//  OpenDocumentCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор сцен открытия объектов (файлов/каталогов)
protocol IOpenDocumentCoordinator: ICoordinator {
	var currentPath: String { get set }
	var mainFlowType: MainFlowOption? { get set }
	func showOpenDocumentScene()
	func showAboutScene()
	/// - Parameter createAction: Замыкание `(String) -> Void)`.
	func showNewFileScene(createAction: @escaping (String) -> Void)
	/// - Parameter currentPath: `String`.
	/// - Parameter mainFlowType: Перечисление `MainFlowOption`.
	func openDocument(currentPath: String, mainFlowType: MainFlowOption?)
	/// - Parameter currentPath: `String`.
	/// - Parameter mainFlowType: Перечисление `MainFlowOption`.
	func openFolder(currentPath: String, mainFlowType: MainFlowOption?)
}

/// Координатор сцен открытия объектов (файлов/каталогов)
final class OpenDocumentCoordinator: IOpenDocumentCoordinator {

	// MARK: - Nested types

	enum OpenCoordinatorObjectType {
		case document
		case folder
	}

	// MARK: Internal properties

	var currentPath: String
	var mainFlowType: MainFlowOption?
	var objectType: OpenCoordinatorObjectType? = .folder
	weak var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lificycle

	init(currentPath: String = StringConstants.root, navigationController: UINavigationController) {
		self.currentPath = currentPath
		self.navigationController = navigationController
	}

	// MARK: IOpenDocumentCoordinator

	func showOpenDocumentScene() {

		switch self.objectType {
		case .folder:
			let openDocumentViewController = OpenDocumentAssembly.assemble(
				currentPath: currentPath,
				openDocumentCoordinator: self
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

	func openDocument(currentPath: String, mainFlowType: MainFlowOption?) {
		prepareToStart(currentPath: currentPath, mainFlowType: mainFlowType, objectType: .document)
	}
	func openFolder(currentPath: String, mainFlowType: MainFlowOption?) {
		prepareToStart(currentPath: currentPath, mainFlowType: mainFlowType, objectType: .folder)
	}

	// MARK: ICoordinator

	func start() {
		switch self.mainFlowType {
		case .createDocument(let createAction):
			showNewFileScene(createAction: createAction)
		case .openDirectoryObject:
			showOpenDocumentScene()
		case .aboutApp:
			showAboutScene()
		case .none:
			fatalError("Ошибка. Не передано обязательное значение mainFlowType")
		}
	}
}

// MARK: Private methods

private extension OpenDocumentCoordinator {
	func prepareToStart(currentPath: String, mainFlowType: MainFlowOption?, objectType: OpenCoordinatorObjectType) {
		self.currentPath = currentPath
		self.mainFlowType = mainFlowType
		self.objectType = objectType
		start()
	}
}
