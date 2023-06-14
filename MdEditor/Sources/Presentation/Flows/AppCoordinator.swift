//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 27.04.2023.
//

import UIKit

protocol IAppCoordinator: ICoordinator {
	/// Показывает сцену авторизации.
	func showAuthScene()
}

final class AppCoordinator: IAppCoordinator, ICoordinatorFinishDelegate {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Lifecycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - ICoordinator

	func start() {
		showAuthScene()
	}

	// MARK: - IAppCoordinator

	func showAuthScene() {
		let authCoordinator = AuthCoordinator(
			navigationController: navigationController,
			finishDelegate: finishDelegate
		)
		childCoordinators.append(authCoordinator)
		authCoordinator.start()
	}
}
