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

	// MARK: - Lificycle

	init(
		presenter: IAboutScenePresenter,
		fileExplorerManager: IFileExplorerManager
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
	}

	// MARK: - IAboutSceneInteractor

	func fetchData() {
		guard let aboutFile = fileExplorerManager.getAboutFile() else { return }
		let response = AboutSceneModel.ViewData(information: aboutFile.getFileText(fullPath: aboutFile.path))
		presenter.presentData(response: response)
	}
}
