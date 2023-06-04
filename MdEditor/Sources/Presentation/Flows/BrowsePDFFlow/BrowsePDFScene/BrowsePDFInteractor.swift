//
//  BrowsePDFInteractor.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Интерактор сцены просмотра pdf-файла.
protocol IBrowsePDFInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
}

/// Интерактор сцены просмотра html-файла.
final class BrowsePDFInteractor: IBrowsePDFInteractor {

	// MARK: - Private properties

	private let presenter: IBrowsePDFPresenter
	private let coordinator: IBrowsePDFCoordinator
	private let file: DirectoryObject
	private let converter: IMdToPDFConverter

	// MARK: - Lificycle

	init(
		presenter: IBrowsePDFPresenter,
		coordinator: IBrowsePDFCoordinator,
		file: DirectoryObject,
		converter: IMdToPDFConverter
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.file = file
		self.converter = converter
	}

	deinit {
		coordinator.finish()
	}

	// MARK: - Methods

	/// Получает данные для отображения на вью.
	func fetchData() {
		guard let text = file.getFileText() else { return }
		let pdfData = converter.convert(text: text, pdfAuthor: "Author", pdfTitle: "Some Title")
		let response = BrowsePDFModel.Response(text: text, pdfData: pdfData)
		presenter.presentData(response: response)
	}
}
