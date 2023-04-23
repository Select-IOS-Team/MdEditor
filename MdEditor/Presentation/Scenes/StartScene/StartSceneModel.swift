//
//  StartSceneModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

/// Модель стартовой сцены.
enum StartSceneModel {

	struct Response {}

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

		enum MenuItemType {
			case new
			case open
			case about
		}

		let recentFileItems: [RecentFileItem]
		let menuItems: [MenuItem]
	}
}
