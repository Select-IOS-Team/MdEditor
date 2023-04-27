//
//  OpenDocumentAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit
import Foundation

/// Сборщик сцены OpenDocumentScene.
enum OpenDocumentAssembly {
	static func assemble(currentPath: String, navigationController: UINavigationController) -> OpenDocumentViewController {

		let fileExplorerManager = FileExplorerManager()
		let convertToResponseWorker = OpenDocumentWorker()
		let openDocumentPresenter = OpenDocumentPresenter()
		let coordinator = OpenDocumentCoordinator(
			currentPath: currentPath,
			navigationController: navigationController
		)
		let openDocumentInteractor = OpenDocumentInteractor(
			presenter: openDocumentPresenter,
			convertToResponseWorker: convertToResponseWorker,
			fileExplorerManager: fileExplorerManager,
			coordinator: coordinator
		)
		openDocumentInteractor.currentPath = currentPath
		let openDocumentViewController = OpenDocumentViewController(interactor: openDocumentInteractor)
		openDocumentPresenter.viewController = openDocumentViewController

		return openDocumentViewController
	}
}
