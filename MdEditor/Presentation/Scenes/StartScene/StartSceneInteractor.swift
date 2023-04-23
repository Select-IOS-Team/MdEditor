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
}
