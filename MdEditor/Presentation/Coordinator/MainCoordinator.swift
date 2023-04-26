//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Координатор главного потока
protocol IMainCoordinator: ICoordinator {
	var currentPath: String { get set }
	var mainFlowType: StartSceneModel.ViewData.MenuItemType? { get set }
	func showStartSceneFlow()
	func showOpenDocumentFlow()
}

/// Координатор главного потока
final class MainCoordinator: IMainCoordinator {

	// MARK: Internal properties

	var currentPath: String
	var mainFlowType: StartSceneModel.ViewData.MenuItemType?
	var finishDelegate: ICoordinatorFinishDelegate?
	var navigationController: UINavigationController
	var childCoordinators: [ICoordinator] = []

	// MARK: Lificycle

	init(currentPath: String, navigationController: UINavigationController) {
		self.currentPath = currentPath
		self.navigationController = navigationController
	}

	// MARK: ICoordinator

	func start() {

		if self.mainFlowType == nil {
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
		let openDocumentCoordinator = OpenDocumentCoordinator(
			currentPath: currentPath,
			navigationController: navigationController
		)
		childCoordinators.append(openDocumentCoordinator)
		openDocumentCoordinator.mainFlowType = mainFlowType
		openDocumentCoordinator.start()
	}
}
