//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

// Варианты открытия сценариев
enum MainFlowOption {
	case createDocument(createAction: (String) -> Void)
	case openDirectoryObject
	case aboutApp
}

/// Координатор приложения
protocol IAppCoordinator: ICoordinator {
	/// Вариант открытия сценариев
	var mainFlowOption: MainFlowOption? { get set }
	/// Показывает сценарий стартовой сцены
	func showStartSceneFlow()
}

/// Координатор приложения
final class AppCoordinator: IAppCoordinator {

	// MARK: Internal properties

	var mainFlowOption: MainFlowOption?
	weak var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lificycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: ICoordinator

	func start() {
		showStartSceneFlow()
	}

	// MARK: IAppCoordinator

	func showStartSceneFlow() {
		let startSceneCoordinator = StartSceneCoordinator(navigationController: navigationController)
		childCoordinators.append(startSceneCoordinator)
		startSceneCoordinator.start()
	}
}
