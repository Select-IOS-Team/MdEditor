//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

// Варианты открытия главного потока
enum MainFlowOption {
	case createDocument(createAction: (String) -> Void)
	case openDirectoryObject
	case aboutApp
}

/// Координатор главного потока
protocol IMainCoordinator: ICoordinator {
	var mainFlowOption: MainFlowOption? { get set }
	func showStartSceneFlow()
	func showOpenDocumentFlow()
}

/// Координатор главного потока
final class MainCoordinator: IMainCoordinator {

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
