//
//  StartSceneCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

protocol IStartSceneCoordinator: ICoordinator {
	/// Показывает сценарий стартовой сцены.
	func showStartSceneFlow()
}

/// Координатор открытия стартовой сцены приложения.
final class StartSceneCoordinator: IStartSceneCoordinator {

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
		showStartSceneFlow()
	}

	func showStartSceneFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		let startSceneViewController = StartSceneAssembly.assemble(mainCoordinator: mainCoordinator)
		navigationController.pushViewController(startSceneViewController, animated: true)
	}
}
