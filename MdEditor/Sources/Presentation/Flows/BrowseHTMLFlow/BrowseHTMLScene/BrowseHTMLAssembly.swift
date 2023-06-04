//
//  BrowseHTMLAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

/// Сборщик сцены просмотра файла в виде HTML-страницы..
enum BrowseHTMLAssembly {

	static func assemble(coordinator: IBrowseHTMLCoordinator, file: DirectoryObject) -> BrowseHTMLViewController {
		let converter = MdToHTMLConverter()
		let presenter = BrowseHTMLPresenter()
		let interactor = BrowseHTMLInteractor(
			presenter: presenter,
			coordinator: coordinator,
			file: file,
			converter: converter
		)
		let viewController = BrowseHTMLViewController(interactor: interactor)
		presenter.viewController = viewController
		return viewController
	}
}
