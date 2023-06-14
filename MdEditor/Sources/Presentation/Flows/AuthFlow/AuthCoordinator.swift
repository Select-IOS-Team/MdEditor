//
//  AuthCoordinator.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit

protocol IAuthCoordinator: ICoordinator {
	/// Открывает стартовую сцену.
	func showStartScene()
}

final class AuthCoordinator: IAuthCoordinator {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Lifecycle

	init(
		navigationController: UINavigationController,
		finishDelegate: ICoordinatorFinishDelegate?
	) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
	}

	// MARK: - ICoordinator

	func start() {
		let authViewController = AuthSceneAssembly.assemble(coordinator: self)
		navigationController.show(authViewController, sender: nil)
	}

	// MARK: - IAuthCoordinator

	func didCloseEditFileScene() {
		finish()
	}

	func showStartScene() {
		let startCoordinator = StartCoordinator(navigationController: navigationController)
		childCoordinators.append(startCoordinator)
		startCoordinator.start()
	}
}
