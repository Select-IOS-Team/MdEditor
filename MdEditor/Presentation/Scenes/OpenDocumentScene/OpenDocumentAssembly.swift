//
//  OpenDocumentAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Сборщик сцены OpenDocumentScene.
enum OpenDocumentAssembly {
	static func assemble() -> OpenDocumentViewController {

		let fileExplorerWorker = FileExplorerManager()
		let convertToResponseWorker = OpenDocumentWorker()
		let openDocumentPresenter = OpenDocumentPresenter()
		let openDocumentInteractor = OpenDocumentInteractor(
			presenter: openDocumentPresenter,
			convertToResponseWorker: convertToResponseWorker,
			fileExplorerWorker: fileExplorerWorker
		)
		let openDocumentRouter = OpenDocumentRouter()
		let openDocumentViewController = OpenDocumentViewController(
			interactor: openDocumentInteractor,
			router: openDocumentRouter
		)
		openDocumentPresenter.viewController = openDocumentViewController
		openDocumentRouter.viewController = openDocumentViewController

		return openDocumentViewController
	}
}
