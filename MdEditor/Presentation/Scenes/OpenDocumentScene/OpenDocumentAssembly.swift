//
//  OpenDocumentAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Сборщик сцены OpenDocumentScene.
enum OpenDocumentAssembly {
	static func assemble(currentPath: String) -> OpenDocumentViewController {

		let fileExplorerWorker = FileExplorerManager()
		let convertToResponseWorker = OpenDocumentWorker()
		let openDocumentPresenter = OpenDocumentPresenter()
		let openDocumentInteractor = OpenDocumentInteractor(
			presenter: openDocumentPresenter,
			convertToResponseWorker: convertToResponseWorker,
			fileExplorerWorker: fileExplorerWorker
		)
		openDocumentInteractor.currentPath = currentPath
		let openDocumentRouter = OpenDocumentRouter()
		let openDocumentViewController = OpenDocumentViewController(
			interactor: openDocumentInteractor,
			router: openDocumentRouter
		)
		openDocumentPresenter.viewController = openDocumentViewController
		openDocumentRouter.viewController = openDocumentViewController

		guard let title = currentPath.split(separator: "/").last else { return openDocumentViewController }
		openDocumentViewController.title = title.description
		return openDocumentViewController
	}
}
