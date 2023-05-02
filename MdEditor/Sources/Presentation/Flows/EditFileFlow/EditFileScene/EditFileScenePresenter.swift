//
//  EditFileScenePresenter.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import Foundation

/// Презентер сцены редактирования файла.
protocol IEditFileScenePresenter {
	/// Подготавливает и передаёт вью данные о редактируемом файле.
	/// - Parameter response: Модель `EditFileSceneModel.Response`.
	func presentData(response: EditFileSceneModel.Response)
}

/// Презентер сцены редактирования файла.
final class EditFileScenePresenter: IEditFileScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IEditFileSceneViewController?

	// MARK: - IEditFileScenePresenter

	func presentData(response: EditFileSceneModel.Response) {
		let viewData = EditFileSceneModel.ViewData(text: response.text)
		viewController?.render(viewData: viewData)
	}
}
