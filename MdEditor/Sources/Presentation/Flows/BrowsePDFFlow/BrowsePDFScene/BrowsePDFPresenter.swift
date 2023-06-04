//
//  BrowsePDFPresenter.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

/// Презентер сцены просмотра pdf-файла.
protocol IBrowsePDFPresenter {
	/// Подготавливает и передаёт вью данные файла.
	/// - Parameter response: Модель `BrowsePDFSceneModel.Response`.
	func presentData(response: BrowsePDFModel.Response)
}

/// Презентер сцены просмотра pdf-файла.
final class BrowsePDFPresenter: IBrowsePDFPresenter {

	// MARK: - Internal properties

	weak var viewController: IBrowsePDFViewController?

	// MARK: - Methods
	
	/// Подготавливает и передаёт вью данные файла.
	/// - Parameter response: Модель `BrowsePDFSceneModel.Response`.
	func presentData(response: BrowsePDFModel.Response) {
		let viewData = BrowsePDFModel.ViewData(text: response.text, pdfData: response.pdfData)
		viewController?.render(viewData: viewData)
	}
}
