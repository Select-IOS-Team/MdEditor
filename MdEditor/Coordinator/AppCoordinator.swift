//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

protocol IAppCoordinator: ICoordinator {
	var currentPath: String { get set }
	func showMainFlow()
}

final class AppCoordinator: IAppCoordinator {

	var currentPath: String
	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	init(currentPath: String, navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.currentPath = currentPath
	}

	func showMainFlow() {
		let mainCoordinator = MainCoordinator(currentPath: currentPath, navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()
	}

	func start() {
		showMainFlow()
	}
}
