//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 27.04.2023.
//

import UIKit

/// Делегат, оповещающий о завершении flow.
protocol ICoordinatorFinishDelegate: AnyObject {
	/// Уведомляет о завершении flow.
	/// - Parameter coordinator: Координатор завершённого flow.
	func didFinish(coordinator: ICoordinator)
}

extension ICoordinatorFinishDelegate where Self: ICoordinator {

	func didFinish(coordinator: ICoordinator) {
		childCoordinators.removeAll { $0 === coordinator }
	}
}

/// Общий протокол всех координаторов.
protocol ICoordinator: AnyObject {
	/// UINavigationController flow координатора.
	var navigationController: UINavigationController { get set }
	/// Список дочерних координаторов.
	var childCoordinators: [ICoordinator] { get set }
	/// Делегат, оповещающий о завершении flow.
	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	/// Стартует flow.
	func start()
	/// Финиширует flow.
	func finish()
}

extension ICoordinator {

	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(coordinator: self)
	}
}
