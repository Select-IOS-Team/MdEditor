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

	// MARK: - IOpenDocumentRoutingLogic

	func routeToViewController(menuItem: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType, currentPath: String) {

		switch menuItem {
		case .folder:
			let destinationViewController = OpenDocumentAssembly.assemble(currentPath: currentPath)
			guard let sourceDocumentViewController = viewController else { return }
			sourceDocumentViewController.show(destinationViewController, sender: nil)
		default:
			return
		}
	}
}
