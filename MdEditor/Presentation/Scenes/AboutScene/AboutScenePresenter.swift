//
//  AboutScenePresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Презентер сцены информации о приложении.
protocol IAboutScenePresenter {
	/// Подготавливает и передаёт вью данные об информации о приложении.
	/// - Parameter response: Модель `AboutSceneModel.ViewData`.
	func presentData(response: AboutSceneModel.ViewData)
}

/// Презентер сцены информации о приложении
final class AboutScenePresenter: IAboutScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IAboutSceneViewController?

	// MARK: - IStartScenePresenter

	func presentData(response: AboutSceneModel.ViewData) {
		viewController?.render(viewData: response)
	}
}
