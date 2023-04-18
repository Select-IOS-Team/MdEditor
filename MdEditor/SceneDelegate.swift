//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = MdEditorBuilder.build()
		self.window?.makeKeyAndVisible()
	}

}
