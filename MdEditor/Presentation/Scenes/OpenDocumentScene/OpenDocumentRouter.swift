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
	func routeToViewController(menuItem: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType)
}

protocol IOpenDocumentDataPassing {
	var dataStore: OpenDocumentRoutingDTO? { get set }
}

/// Роутер  сцены открытия файлов и каталогов.
final class OpenDocumentRouter: IOpenDocumentRoutingLogic, IOpenDocumentDataPassing {

	// MARK: - Internal properties

	weak var viewController: IOpenDocumentViewController?
	var dataStore: OpenDocumentRoutingDTO?

	// MARK: - IStartSceneRouter

	func routeToViewController(menuItem: OpenDocumentModel.OpenDocumentViewData.DirectoryObjectType) {

		switch menuItem {
		case .folder:
			guard let dataStore = dataStore else { return }
			let destinationViewController = OpenDocumentAssembly.assemble()
			guard let sourceDocumentViewController = viewController as? OpenDocumentViewController else { return }

			passDataToViewController(source: dataStore, destination: destinationViewController)
			navigateToViewController(source: sourceDocumentViewController, destination: destinationViewController)
		default:
			return
		}
	}

	// MARK: - Private methods

	private func navigateToViewController(source: OpenDocumentViewController, destination: OpenDocumentViewController) {
		source.show(destination, sender: nil)
	}

	private func passDataToViewController(source: OpenDocumentRoutingDTO, destination: OpenDocumentViewController) {

		destination.title = source.title
		destination.currentPath = source.currentPath
	  }
}

struct OpenDocumentRoutingDTO {
	let title: String
	let currentPath: String
}
