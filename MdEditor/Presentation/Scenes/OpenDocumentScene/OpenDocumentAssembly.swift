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
	static func assemble(
		currentPath: String,
		openDocumentCoordinator: MainCoordinator
	) -> OpenDocumentViewController {

		let fileExplorerManager = FileExplorerManager()
		let convertToResponseWorker = OpenDocumentWorker()
		let openDocumentPresenter = OpenDocumentPresenter()
		let openDocumentInteractor = OpenDocumentInteractor(
			presenter: openDocumentPresenter,
			convertToResponseWorker: convertToResponseWorker,
			fileExplorerManager: fileExplorerManager,
			openDocumentCoordinator: openDocumentCoordinator,
			currentPath: currentPath
		)
		let openDocumentViewController = OpenDocumentViewController(interactor: openDocumentInteractor)
		openDocumentPresenter.viewController = openDocumentViewController

		return openDocumentViewController
	}
}
