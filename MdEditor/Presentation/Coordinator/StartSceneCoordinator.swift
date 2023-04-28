//
//  StartSceneCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор открытия стартовой сцены приложения
protocol IStartSceneCoordinator: ICoordinator {
	func showStartScene()
}

/// Координатор открытия стартовой сцены приложения
final class StartSceneCoordinator: IStartSceneCoordinator {

	// MARK: Internal properties

	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lifecycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: IStartSceneCoordinator

	func showStartScene() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		let startSceneViewController = StartSceneAssembly.assemble(mainCoordinator: mainCoordinator)
		navigationController.pushViewController(startSceneViewController, animated: true)
	}

	// MARK: ICoordinator

	func start() {
		showStartScene()
	}
}
