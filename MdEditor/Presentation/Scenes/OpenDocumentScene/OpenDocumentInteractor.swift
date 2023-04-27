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
	func coordinate(currentPath: String, objectType: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType)
}

/// Класс интерактора
final class OpenDocumentInteractor: IOpenDocumentInteractor {

	// MARK: - Private properties

	private let presenter: IOpenDocumentPresenter
	private let convertToResponseWorker: IOpenDocumentWorker
	private let fileExplorerManager: IFileExplorerManager
	private let coordinator: IOpenDocumentCoordinator

	var currentPath = ""

	// MARK: - Lifecycle

	init(
		presenter: IOpenDocumentPresenter,
		convertToResponseWorker: IOpenDocumentWorker,
		fileExplorerManager: IFileExplorerManager,
		coordinator: IOpenDocumentCoordinator
	) {
		self.presenter = presenter
		self.convertToResponseWorker = convertToResponseWorker
		self.fileExplorerManager = fileExplorerManager
		self.coordinator = coordinator
	}

	// MARK: - IOpenDocumentInteractor

	func fetchDirectoryObjects() {
		let data = fileExplorerManager.fillDirectoryObjects(path: currentPath)
		guard let title = currentPath.split(separator: "/").last else { return }
		let response = convertToResponseWorker.prepareViewModel(data: data, title: String(title))
		presenter.presentData(response: response)
	}

	func coordinate(currentPath: String, objectType: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType) {

		switch objectType {
		case .folder:
			coordinator.objectType = OpenCoordinatorObjectType.folder
		case .document:
			coordinator.objectType = OpenCoordinatorObjectType.document
		}

		coordinator.currentPath = currentPath
		coordinator.mainFlowType = MainFlowType.open
		coordinator.start()
	}
}
