//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Делегат
protocol ICoordinatorFinishDelegate: AnyObject {
	func didFinish(_ coordinator: ICoordinator)
}

/// Координатор
protocol ICoordinator: AnyObject {
	var finishDelegate: ICoordinatorFinishDelegate? { get set }
	var navigationController: UINavigationController { get set }
	var childCoordinators: [ICoordinator] { get set }
	func start()
	func finish()
}

extension ICoordinator {
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}
}
