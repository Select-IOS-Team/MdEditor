//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор сценариев
protocol IAppCoordinator: ICoordinator {
	func showMainFlow()
}

/// Координатор сценариев
final class AppCoordinator: IAppCoordinator {

	// MARK: Internal properties

	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: IAppCoordinator

	func showMainFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()
	}

	// MARK: ICoordinator

	func start() {
		showMainFlow()
	}
}
