//
//  StartSceneCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор открытия стартовой сцены приложения
final class StartSceneCoordinator: ICoordinator {

	// MARK: Internal properties

	weak var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lifecycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: ICoordinator

	func start() {
		showStartScene()
	}
}

// MARK: Private methods
private extension StartSceneCoordinator {
	func showStartScene() {
		let appCoordinator = AppCoordinator(navigationController: navigationController)
		childCoordinators.append(appCoordinator)
		let startSceneViewController = StartSceneAssembly.assemble(appCoordinator: appCoordinator)
		navigationController.pushViewController(startSceneViewController, animated: true)
	}
}
