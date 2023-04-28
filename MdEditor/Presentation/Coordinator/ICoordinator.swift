//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 26.04.2023.
//

import UIKit

/// Делегат завершения работы координатора
protocol ICoordinatorFinishDelegate: AnyObject {
	/// - Parameter coordinator: Протокол `ICoordinator`.
	func didFinish(_ coordinator: ICoordinator)
}

/// Координатор
protocol ICoordinator: AnyObject {
	/// Делегат завершения
	var finishDelegate: ICoordinatorFinishDelegate? { get set }
	var navigationController: UINavigationController { get set }
	/// Дочерние координаторы
	var childCoordinators: [ICoordinator] { get set }
	/// Стартует сценарий
	func start()
	/// Освобождает все дочерние координаторы
	func finish()
}

extension ICoordinator {
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}
}
