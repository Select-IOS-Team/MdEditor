//
//  BrowseHTMLPresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

/// Презентер сцены просмотра файла в виде HTML-страницы..
protocol IBrowseHTMLPresenter {
	/// Подготавливает и передаёт вью данные файла.
	/// - Parameter response: Модель `BrowseHTMLSceneModel.Response`.
	func presentData(response: BrowseHTMLModel.Response)
}

/// Презентер сцены просмотра файла в виде HTML-страницы..
final class BrowseHTMLPresenter: IBrowseHTMLPresenter {

	// MARK: - Internal properties

	weak var viewController: IBrowseHTMLViewController?

	// MARK: - IEditFileScenePresenter

	func presentData(response: BrowseHTMLModel.Response) {
		let viewData = BrowseHTMLModel.ViewData(text: response.text, htmlText: response.htmlText)
		viewController?.render(viewData: viewData)
	}
}
