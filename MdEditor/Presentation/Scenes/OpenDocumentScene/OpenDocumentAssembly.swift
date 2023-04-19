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

		let fileExplorerWorker: IFileExplorerWorker = FileExplorerWorker()
		let convertToResponseWorker: IOpenDocumentWorker = OpenDocumentWorker()
		let openDocumentPresenter = OpenDocumentPresenter()
		let openDocumentInteractor = OpenDocumentInteractor(
			presenter: openDocumentPresenter,
			convertToResponseWorker: convertToResponseWorker,
			fileExplorerWorker: fileExplorerWorker
		)
		let openDocumentViewController = OpenDocumentViewController(interactor: openDocumentInteractor)
		openDocumentPresenter.viewController = openDocumentViewController

		return openDocumentViewController
	}
}
