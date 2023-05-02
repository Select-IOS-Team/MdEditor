//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	// MARK: - Internal properties

	var window: UIWindow?

	// MARK: - Lifecycle

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: windowScene)
		let navigationController = UINavigationController()
		let appCoordinator = AppCoordinator(navigationController: navigationController)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		appCoordinator.start()
	}
}
