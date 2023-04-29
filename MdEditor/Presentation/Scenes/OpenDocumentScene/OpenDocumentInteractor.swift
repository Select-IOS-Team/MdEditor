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
	func handleSelectedDirectoryObject(
		currentPath: String,
		objectType: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType
	)
}

/// Класс интерактора
final class OpenDocumentInteractor: IOpenDocumentInteractor {

	// MARK: - Private properties

	private let presenter: IOpenDocumentPresenter
	private let convertToResponseWorker: IOpenDocumentWorker
	private let fileExplorerManager: IFileExplorerManager
	private let openDocumentCoordinator: IMainCoordinator
	private var currentPath = ""

	// MARK: - Lifecycle

	init(
		presenter: IOpenDocumentPresenter,
		convertToResponseWorker: IOpenDocumentWorker,
		fileExplorerManager: IFileExplorerManager,
		openDocumentCoordinator: IMainCoordinator,
		currentPath: String
	) {
		self.presenter = presenter
		self.convertToResponseWorker = convertToResponseWorker
		self.fileExplorerManager = fileExplorerManager
		self.openDocumentCoordinator = openDocumentCoordinator
		self.currentPath = currentPath
	}

	// MARK: - IOpenDocumentInteractor

	func fetchDirectoryObjects() {
		let data = fileExplorerManager.fillDirectoryObjects(path: currentPath)
		guard let title = currentPath.split(separator: "/").last else { return }
		let response = convertToResponseWorker.prepareViewModel(data: data, title: String(title))
		presenter.presentData(response: response)
	}

	func handleSelectedDirectoryObject(
		currentPath: String,
		objectType: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType
	) {
		switch objectType {
		case .folder:
			openDocumentCoordinator.openFolder(currentPath: currentPath, mainFlowOption: MainFlowOption.openDirectoryObject)
		case .document:
			openDocumentCoordinator.openDocument(currentPath: currentPath, mainFlowOption: MainFlowOption.openDirectoryObject)
		}
	}
}
