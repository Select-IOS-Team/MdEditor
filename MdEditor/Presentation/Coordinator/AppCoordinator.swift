//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор сценариев
protocol IAppCoordinator: ICoordinator {
	var currentPath: String { get set }
	func showMainFlow()
}

/// Координатор сценариев
final class AppCoordinator: IAppCoordinator {

	// MARK: Internal properties

	var currentPath: String
	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	init(currentPath: String, navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.currentPath = currentPath
	}

	// MARK: IAppCoordinator

	func showMainFlow() {
		let mainCoordinator = MainCoordinator(currentPath: currentPath, navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()
	}

	// MARK: ICoordinator

	func start() {
		showMainFlow()
	}
}
