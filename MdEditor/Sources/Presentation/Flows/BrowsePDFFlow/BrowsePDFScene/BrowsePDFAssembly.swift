//
//  BrowsePDFAssembly.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

/// Сборщик сцены просмотра pdf-файла.
enum BrowsePDFAssembly {
	/// Метод для сборки сцены `BrowsePDF`.
	/// - Parameters:
	///   - coordinator: Принимает координатор сцены.
	///   - file: Принимает файл для отображения на сцене.
	/// - Returns: Возвращает ViewController, который отображает pdf-документы на экране.
	static func assemble(coordinator: IBrowsePDFCoordinator, file: DirectoryObject) -> BrowsePDFViewController {
		let converter = MdToPDFConverter()
		let presenter = BrowsePDFPresenter()
		let interactor = BrowsePDFInteractor(
			presenter: presenter,
			coordinator: coordinator,
			file: file,
			converter: converter
		)
		let viewController = BrowsePDFViewController(interactor: interactor)
		presenter.viewController = viewController
		return viewController
	}
}
