//
//  OpenDocumentPresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Презентер, подготавливающий модель вью для OpenDocumentViewController.
protocol IOpenDocumentPresenter {
	func presentData(response: [OpenDocumentModel.OpenDocumentViewData.FileViewModel])
}

/// Класс презентера
class OpenDocumentPresenter: IOpenDocumentPresenter {

	// MARK: - Internal Properties

	weak var viewController: IOpenDocumentViewController?

	// MARK: - Internal Methods

	func presentData(response: [OpenDocumentModel.OpenDocumentViewData.FileViewModel]) {
		viewController?.render(viewData: response)
	}
}
