//
//  BrowseHTMLCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit

/// Координатор сцены просмотра html-файла.
protocol IBrowseHTMLCoordinator: ICoordinator {
	/// Уведомляет о закрытии сцены просмотра html-файла.
	func didCloseBrowseHTMLScene()
}

/// Координатор сцены просмотра html-файла.
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

	func start() {
		let browseHTMLViewController = BrowseHTMLAssembly.assemble(coordinator: self, file: file)
		navigationController.show(browseHTMLViewController, sender: nil)
	}
}
