//
//  AboutAppScenePresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Презентер сцены информации о приложении.
protocol IAboutAppScenePresenter {
	/// Подготавливает и передаёт вью данные об информации о приложении.
	/// - Parameter response: Модель `AboutAppSceneModel.Response`.
	func presentData(response: AboutAppSceneModel.Response)
}

/// Презентер сцены информации о приложении.
final class AboutAppScenePresenter: IAboutAppScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IAboutAppSceneViewController?

	// MARK: - IStartScenePresenter

	func presentData(response: AboutAppSceneModel.Response) {
		let viewData = AboutAppSceneModel.ViewData(information: response.information)
		viewController?.render(viewData: viewData)
	}
}
