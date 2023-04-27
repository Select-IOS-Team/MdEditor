//
//  StartSceneAssembly.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit
import Foundation

/// Сборщик стартовой сцены.
enum StartSceneAssembly {

	static func assemble(navigationController: UINavigationController) -> StartSceneViewController {
		let presenter = StartScenePresenter()
		let fileExplorerManager = FileExplorerManager()
		let coordinator = MainCoordinator(
			currentPath: StringConstants.root,
			navigationController: navigationController
		)
		let interactor = StartSceneInteractor(
			presenter: presenter,
			fileExplorerManager: fileExplorerManager,
			coordinator: coordinator
		)
		let viewController = StartSceneViewController(interactor: interactor)
		presenter.viewController = viewController

		return viewController
	}
}
