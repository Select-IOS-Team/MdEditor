//
//  StartScenePresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Презентер стартовой сцены.
protocol IStartScenePresenter {
	/// Подготавливает и передаёт вью данные о недавно открытых файлах и элементах меню.
	/// - Parameter response: Модель `StartSceneModel.Response`.
	func presentData(response: StartSceneModel.Response)
}

/// Презентер стартовой сцены.
final class StartScenePresenter: IStartScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IStartSceneViewController?

	// MARK: - IStartScenePresenter

	func presentData(response: StartSceneModel.Response) {
		let viewData = StartSceneModel.ViewData.stubData
		viewController?.render(viewData: viewData)
	}
}

private extension StartSceneModel.ViewData {

	static var stubData: StartSceneModel.ViewData {
		let recentFileItems: [StartSceneModel.ViewData.RecentFileItem] = [
			StartSceneModel.ViewData.RecentFileItem(
				fileName: "File 1.md",
				text: "Подготавливает и передаёт вью данные о недавно открытых файлах и элементах меню.",
				color: .green.withAlphaComponent(0.3)
			),
			StartSceneModel.ViewData.RecentFileItem(
				fileName: "File 2.md",
				text: "Подготавливает и передаёт вью данные о недавно открытых файлах и элементах меню.",
				color: .orange.withAlphaComponent(0.3)
			),
			StartSceneModel.ViewData.RecentFileItem(
				fileName: "File 3.md",
				text: "Подготавливает и передаёт вью данные о недавно открытых файлах и элементах меню.",
				color: .blue.withAlphaComponent(0.3)
			)
		]
		let menuItems: [StartSceneModel.ViewData.MenuItem] = [
			StartSceneModel.ViewData.MenuItem(iconName: L10n.StartScene.Images.addFile, title: "New", menuItem: .new),
			StartSceneModel.ViewData.MenuItem(iconName: L10n.StartScene.Images.openFolder, title: "Open", menuItem: .open),
			StartSceneModel.ViewData.MenuItem(iconName: L10n.StartScene.Images.about, title: "About", menuItem: .about)
		]
		return StartSceneModel.ViewData(recentFileItems: recentFileItems, menuItems: menuItems)
	}
}
