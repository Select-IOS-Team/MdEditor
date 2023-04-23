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

	weak var viewController: UIViewController?

	// MARK: - IStartSceneRouter

	func routeToViewController(menuItem: StartSceneModel.ViewData.MenuItemType) {

		var destinationViewController = UIViewController()

		switch menuItem {
		case .open:
			destinationViewController = OpenDocumentAssembly.assemble(currentPath: StringConstants.root) as UIViewController
		case .about:
			destinationViewController = AboutSceneAssembly.assemble() as UIViewController
		default:
			return
		}

		guard let startSceneViewController = viewController else { return }
		startSceneViewController.show(destinationViewController, sender: nil)
	}
}
