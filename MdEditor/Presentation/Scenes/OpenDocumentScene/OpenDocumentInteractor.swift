//
//  OpenDocumentInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор сцены открытия файлов и папок.
protocol IOpenDocumentInteractor: AnyObject {
	func fetchDirectoryObjects()
}

/// Класс интерактора
final class OpenDocumentInteractor: IOpenDocumentInteractor {

	// MARK: - Private properties

	private let presenter: IOpenDocumentPresenter
	private let convertToResponseWorker: IOpenDocumentWorker
	private let fileExplorerManager: IFileExplorerManager

	var currentPath = ""

	// MARK: - Lifecycle

	init(
		presenter: IOpenDocumentPresenter,
		convertToResponseWorker: IOpenDocumentWorker,
		fileExplorerManager: IFileExplorerManager
	) {
		self.presenter = presenter
		self.convertToResponseWorker = convertToResponseWorker
		self.fileExplorerManager = fileExplorerManager
	}

	// MARK: - IOpenDocumentInteractor

	func fetchDirectoryObjects() {
		let data = fileExplorerManager.fillDirectoryObjects(path: currentPath)
		guard let title = currentPath.split(separator: "/").last else { return }
		let response = convertToResponseWorker.prepareViewModel(data: data, title: String(title))
		presenter.presentData(response: response)
	}
}
