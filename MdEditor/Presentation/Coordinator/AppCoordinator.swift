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
	/// Показывает сценарий открытия каталогов и файлов
	func showOpenDocumentFlow()
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

		if self.mainFlowOption == nil {
			showStartSceneFlow()
		} else {
			showOpenDocumentFlow()
		}
	}

	// MARK: IMainCoordinator

	func showStartSceneFlow() {
		let startSceneCoordinator = StartSceneCoordinator(navigationController: navigationController)
		childCoordinators.append(startSceneCoordinator)
		startSceneCoordinator.start()
	}

	func showOpenDocumentFlow() {
		let openDocumentCoordinator = OpenDocumentCoordinator(navigationController: navigationController)
		childCoordinators.append(openDocumentCoordinator)
		openDocumentCoordinator.mainFlowType = mainFlowOption
		openDocumentCoordinator.start()
	}
}
