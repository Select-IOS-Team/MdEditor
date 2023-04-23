//
//  OpenDocumentPresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Презентер, подготавливающий модель вью для OpenDocumentViewController.
protocol IOpenDocumentPresenter {
	func presentData(response: OpenDocumentModel.OpenDocumentViewData)
}

/// Класс презентера
final class OpenDocumentPresenter: IOpenDocumentPresenter {

	// MARK: - Internal Properties

	weak var viewController: IOpenDocumentViewController?

	// MARK: - IOpenDocumentPresenter

	func presentData(response: OpenDocumentModel.OpenDocumentViewData) {
		viewController?.render(viewData: response)
	}
}
