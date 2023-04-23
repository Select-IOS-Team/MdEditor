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

	// MARK: - Private Properties

	private let presenter: IOpenDocumentPresenter
	private let convertToResponseWorker: IOpenDocumentWorker
	private let fileExplorerWorker: IFileExplorerManager

	var currentPath = ""

	// MARK: - Lifecycle

	init(
		presenter: IOpenDocumentPresenter,
		convertToResponseWorker: IOpenDocumentWorker,
		fileExplorerWorker: IFileExplorerManager
	) {
		self.presenter = presenter
		self.convertToResponseWorker = convertToResponseWorker
		self.fileExplorerWorker = fileExplorerWorker
	}

	// MARK: - IFileExplorerWorker

	func fetchDirectoryObjects() {
		let data = fileExplorerWorker.fillDirectoryObjects(path: currentPath)
		let response = convertToResponseWorker.prepareViewModel(data: data)
		presenter.presentData(response: response)
	}
}
