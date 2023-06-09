//
//  BrowsePDFCoordinator.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit

/// Координатор флоу просмотра pdf-файла.
protocol IBrowsePDFCoordinator: ICoordinator {}

/// Координатор флоу просмотра pdf-файла.
final class BrowsePDFCoordinator: IBrowsePDFCoordinator {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Private properties

	private let file: DirectoryObject

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

	// MARK: - ICoordinator

	func start() {
		let browsePDFViewController = BrowsePDFAssembly.assemble(coordinator: self, file: file)
		navigationController.show(browsePDFViewController, sender: nil)
	}
}
