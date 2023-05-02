//
//  StartSceneModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

/// Модель стартовой сцены.
enum StartSceneModel {

	struct Response {
		let createFileAction: (String) -> Void
	}

	struct ViewData {

		struct RecentFileItem {
			let fileName: String
			let text: String
			let color: UIColor
		}

		struct MenuItem {
			let icon: ImageAsset
			let title: String
			let menuType: MenuItemType
		}

		let recentFileItems: [RecentFileItem]
		let menuItems: [MenuItem]
	}

	enum MenuItemType {
		case newFile(createAction: (String) -> Void)
		case openFile
		case aboutApp
	}
}
