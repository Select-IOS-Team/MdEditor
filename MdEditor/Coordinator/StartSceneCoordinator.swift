//
//  StartSceneCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

protocol IStartSceneCoordinator: ICoordinator {
	func showStartScene()
}

final class StartSceneCoordinator: IStartSceneCoordinator {

	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func showStartScene() {
		let startSceneViewController = StartSceneAssembly.assemble()
		navigationController.pushViewController(startSceneViewController, animated: true)
	}

	func start() {
		showStartScene()
	}
}
