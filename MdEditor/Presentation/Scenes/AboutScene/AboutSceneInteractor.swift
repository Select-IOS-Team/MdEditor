//
//  AboutSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Интерактор сцены информации о приложении.
protocol IAboutSceneInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
}

/// Интерактор сцены информации о приложении.
final class AboutSceneInteractor: IAboutSceneInteractor {

	// MARK: - Private properties

	private let presenter: IAboutScenePresenter
	private let fileExplorerManager: IFileExplorerManager
	private let convertToResponseWorker: IAboutSceneWorker

	// MARK: - Lificycle

	init(
		presenter: IAboutScenePresenter,
		fileExplorerManager: IFileExplorerManager,
		convertToResponseWorker: IAboutSceneWorker
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
		self.convertToResponseWorker = convertToResponseWorker
	}

	// MARK: - IAboutSceneInteractor

	func fetchData() {
		guard let file = fileExplorerManager.getAboutFile() else { return }
		let response = convertToResponseWorker.prepareViewModel(data: file)
		presenter.presentData(response: response)
	}
}
