//
//  OpenDocumentRouter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import Foundation
import UIKit

/// Роутер  сцены открытия файлов и каталогов.
protocol IOpenDocumentRoutingLogic {
	func routeToViewController(menuItem: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType, currentPath: String)
}

/// Роутер  сцены открытия файлов и каталогов.
final class OpenDocumentRouter: IOpenDocumentRoutingLogic {

	// MARK: - Internal properties

	weak var viewController: UIViewController?

	// MARK: - IStartSceneRouter

	func routeToViewController(menuItem: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType, currentPath: String) {

		switch menuItem {
		case .folder:
			let destinationViewController = OpenDocumentAssembly.assemble(currentPath: currentPath)
			guard let sourceDocumentViewController = viewController else { return }
			navigateToViewController(source: sourceDocumentViewController, destination: destinationViewController)
		default:
			return
		}
	}

	// MARK: - Private methods

	private func navigateToViewController(source: UIViewController, destination: OpenDocumentViewController) {
		source.show(destination, sender: nil)
	}
}
