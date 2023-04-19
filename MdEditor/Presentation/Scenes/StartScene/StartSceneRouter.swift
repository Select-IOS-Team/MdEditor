//
//  StartSceneRouter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Роутер стартовой сцены.
protocol IStartSceneRouter {}

/// Роутер стартовой сцены.
final class StartSceneRouter: IStartSceneRouter {

	// MARK: - Internal properties

	weak var viewController: IStartSceneViewController?

	// MARK: - IStartSceneRouter
}
