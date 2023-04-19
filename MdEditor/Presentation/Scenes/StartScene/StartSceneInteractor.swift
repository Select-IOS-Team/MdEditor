//
//  StartSceneInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор стартовой сцены.
protocol IStartSceneInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
	/// Уведомляет о нажатии на файл из списка недавних файлов.
	/// - Parameter index: Индекс элемента списка.
	func didTapRecentFile(at index: Int)
	/// Уведомляет о нажатии пункта меню.
	/// - Parameter index: Индекс пункта меню.
	func didTapMenuItem(at index: Int)
}

/// Интерактор стартовой сцены.
final class StartSceneInteractor: IStartSceneInteractor {

	// MARK: - Private properties

	private let presenter: IStartScenePresenter?

	// MARK: - Lificycle

	init(presenter: IStartScenePresenter) {
		self.presenter = presenter
	}

	// MARK: - IStartSceneInteractor

	func fetchData() {
		presenter?.presentData(response: StartSceneModel.Response())
	}

	func didTapRecentFile(at index: Int) {}

	func didTapMenuItem(at index: Int) {}
}
