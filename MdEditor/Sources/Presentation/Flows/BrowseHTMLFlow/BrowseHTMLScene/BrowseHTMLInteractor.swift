//
//  BrowseHTMLInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Интерактор сцены просмотра html-файла.
protocol IBrowseHTMLInteractor: AnyObject {
	/// Получает данные для отображения на вью.
	func fetchData()
}

/// Интерактор сцены просмотра html-файла.
final class BrowseHTMLInteractor: IBrowseHTMLInteractor {

	// MARK: - Private properties

	private let presenter: IBrowseHTMLPresenter
	private let coordinator: IBrowseHTMLCoordinator
	private let file: DirectoryObject
	private let converter: IMdToHTMLConverter

	// MARK: - Lificycle

	init(
		presenter: IBrowseHTMLPresenter,
		coordinator: IBrowseHTMLCoordinator,
		file: DirectoryObject,
		converter: IMdToHTMLConverter
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.file = file
		self.converter = converter
	}

	deinit {
		coordinator.didCloseBrowseHTMLScene()
	}

	func fetchData() {
		guard let text = file.getFileText() else { return }
		let htmlText = converter.convert(text: text)
		let response = BrowseHTMLModel.Response(text: text, htmlText: htmlText)
		presenter.presentData(response: response)
	}
}
