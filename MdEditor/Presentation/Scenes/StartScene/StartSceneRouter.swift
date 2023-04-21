//
//  StartSceneRouter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation
import UIKit

/// Роутер стартовой сцены.
protocol IStartSceneRouter {
	func routeToViewController(menuItem: StartSceneModel.ViewData.MenuItemType)
}

/// Роутер стартовой сцены.
final class StartSceneRouter: IStartSceneRouter {

	// MARK: - Internal properties

	weak var viewController: IStartSceneViewController?

	// MARK: - IStartSceneRouter

	func routeToViewController(menuItem: StartSceneModel.ViewData.MenuItemType) {

		var destinationViewController = UIViewController()

		switch menuItem {
		case .open:
			destinationViewController = OpenDocumentAssembly.assemble() as UIViewController
		default:
			return
		}

		guard let startSceneViewController = viewController as? StartSceneViewController else { return }
		navigateToOpenDocumentViewController(source: startSceneViewController, destination: destinationViewController)
	}

	// MARK: - Private methods

	private func navigateToOpenDocumentViewController(source: StartSceneViewController, destination: UIViewController) {
		source.show(destination, sender: nil)
	}
}
