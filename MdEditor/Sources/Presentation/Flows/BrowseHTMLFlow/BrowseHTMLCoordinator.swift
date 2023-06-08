//
//  BrowseHTMLCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit

/// Координатор флоу просмотра файла в виде HTML-страницы..
protocol IBrowseHTMLCoordinator: ICoordinator {
	/// Уведомляет о закрытии сцены просмотра файла.
	func didCloseBrowseHTMLScene()
}

/// Координатор флоу просмотра файла в виде HTML-страницы..
final class BrowseHTMLCoordinator: IBrowseHTMLCoordinator {

	// MARK: - Private properties

	private let file: DirectoryObject

	// MARK: Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: Lifecycle

	init(
		navigationController: UINavigationController,
		finishDelegate: ICoordinatorFinishDelegate?,
		file: DirectoryObject
	) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
		self.file = file
	}

	func didCloseBrowseHTMLScene() {
		finish()
	}

	// MARK: - ICoordinator

	/// Стартует сцену с просмотром документа в html.
	func start() {
		let browseHTMLViewController = BrowseHTMLAssembly.assemble(coordinator: self, file: file)
		navigationController.show(browseHTMLViewController, sender: nil)
	}
}
