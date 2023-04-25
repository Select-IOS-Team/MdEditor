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
		guard let viewController = viewController else { return }

		switch menuItem {
		case .new(let createAction):
			presentNewFIleAlertController(from: viewController, createAction: createAction)
		case .open:
			let destinationViewController = OpenDocumentAssembly.assemble(currentPath: StringConstants.root)
			viewController.show(destinationViewController, sender: nil)
		case .about:
			let destinationViewController = AboutSceneAssembly.assemble()
			viewController.show(destinationViewController, sender: nil)
		}
	}

	// MARK: - Private methods

	func presentNewFIleAlertController(from viewController: UIViewController, createAction: @escaping (String) -> Void) {
		let alertController = UIAlertController(
			title: L10n.StartScene.NewFileAlert.title,
			message: "",
			preferredStyle: .alert
		)
		let createAction = UIAlertAction(title: L10n.AlertController.Action.Create.title, style: .default) { _ in
			guard let textField = alertController.textFields?.first,
				  let fileName = textField.text else { return }
			createAction(fileName)
		}
		let cancelAction = UIAlertAction(title: L10n.AlertController.Action.Cancel.title, style: .cancel)

		alertController.addTextField { textField in
			textField.placeholder = L10n.StartScene.NewFileAlert.TextField.placeholder
		}
		alertController.addAction(createAction)
		alertController.addAction(cancelAction)

		viewController.present(alertController, animated: false)
	}
}
