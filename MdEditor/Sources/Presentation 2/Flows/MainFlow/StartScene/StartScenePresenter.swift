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
		let menuItems: [StartSceneModel.ViewData.MenuItem] = [
			StartSceneModel.ViewData.MenuItem(
				icon: Asset.newFile,
				title: L10n.StartScene.MenuItem.NewFile.title,
				menuType: .newFile(createAction: response.createFileAction)
			),
			StartSceneModel.ViewData.MenuItem(
				icon: Asset.openFile,
				title: L10n.StartScene.MenuItem.OpenFile.title,
				menuType: .openFile
			),
			StartSceneModel.ViewData.MenuItem(
				icon: Asset.aboutApp,
				title: L10n.StartScene.MenuItem.AboutApp.title,
				menuType: .aboutApp
			)
		]
		let recentFileItems = StartSceneModel.ViewData.stubRecentFileItems
		let viewData = StartSceneModel.ViewData(recentFileItems: recentFileItems, menuItems: menuItems)

		viewController?.render(viewData: viewData)
	}
}

private extension StartSceneModel.ViewData {

	static var stubRecentFileItems: [StartSceneModel.ViewData.RecentFileItem] {
		[
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
	}
}
