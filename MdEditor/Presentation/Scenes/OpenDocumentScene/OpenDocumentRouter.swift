//
//  OpenDocumentRouter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import Foundation
import UIKit

/// Роутер  сцены открытия файлов и каталогов.
protocol IOpenDocumentRouter {
	func routeToViewController(menuItem: MenuItemsOpenDocumentsScene, root: String, title: String)
}

/// Роутер  сцены открытия файлов и каталогов.
final class OpenDocumentRouter: IOpenDocumentRouter {

	// MARK: - Internal properties

	weak var viewController: IOpenDocumentViewController?

	// MARK: - IStartSceneRouter

	func routeToViewController(menuItem: MenuItemsOpenDocumentsScene, root: String, title: String) {

		switch menuItem {
		case .folder:
			let openDocumentViewController = OpenDocumentAssembly.assemble()
			openDocumentViewController.title = title
			openDocumentViewController.interactor?.root = root
			let destinationViewController = openDocumentViewController as UIViewController
			guard let openDocumentViewController = viewController as? OpenDocumentViewController else { return }
			navigateToViewController(source: openDocumentViewController, destination: destinationViewController)
		default:
			return
		}
	}

	// MARK: - Private methods

	private func navigateToViewController(source: OpenDocumentViewController, destination: UIViewController) {
		source.show(destination, sender: nil)
	}
}

enum MenuItemsOpenDocumentsScene {
	case folder
	case document
}
