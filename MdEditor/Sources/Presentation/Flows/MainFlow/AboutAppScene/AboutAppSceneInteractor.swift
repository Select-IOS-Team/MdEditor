//
//  AboutAppSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Интерактор сцены информации о приложении.
protocol IAboutAppSceneInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
}

/// Интерактор сцены информации о приложении.
final class AboutAppSceneInteractor: IAboutAppSceneInteractor {

	// MARK: - Private properties

	private let presenter: IAboutAppScenePresenter
	private let fileExplorerManager: IFileExplorerManager

	// MARK: - Lificycle

	init(
		presenter: IAboutAppScenePresenter,
		fileExplorerManager: IFileExplorerManager
	) {
		self.presenter = presenter
		self.fileExplorerManager = fileExplorerManager
	}

	// MARK: - IAboutAppSceneInteractor

	func fetchData() {
		guard let fileText = fileExplorerManager.getAboutFile()?.getFileText() else { return }
		let response = AboutAppSceneModel.Response(information: fileText)
		presenter.presentData(response: response)
	}
}
