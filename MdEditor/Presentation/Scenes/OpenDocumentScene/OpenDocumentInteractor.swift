//
//  OpenDocumentInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор сцены открытия файлов и папок.
protocol IOpenDocumentInteractor: AnyObject {
	func didCellTapped(indexPath: IndexPath)
	func fetchFileStruct()
}

/// Класс интерактора
class OpenDocumentInteractor: IOpenDocumentInteractor {

	// MARK: - Private Properties

	private let presenter: IOpenDocumentPresenter?
	private let convertToResponseWorker: IOpenDocumentWorker?
	private let fileExplorerWorker: IFileExplorerWorker?

	// MARK: - Internal Properties

	var root = "SampleFiles"

	// MARK: - Lifecycle

	// swiftlint: disable line_length
	init(presenter: IOpenDocumentPresenter, convertToResponseWorker: IOpenDocumentWorker, fileExplorerWorker: IFileExplorerWorker) {
		self.presenter = presenter
		self.convertToResponseWorker = convertToResponseWorker
		self.fileExplorerWorker = fileExplorerWorker
	}
	// swiftlint: enable line_length

	// MARK: - Internal Methods

	func didCellTapped(indexPath: IndexPath) {
	}

	func fetchFileStruct() {
		guard let data = fileExplorerWorker?.fillFiles(path: root) else { return }
		guard let response = convertToResponseWorker?.prepareViewModel(data: data) else { return }
		presenter?.presentData(response: response)
	}
}
