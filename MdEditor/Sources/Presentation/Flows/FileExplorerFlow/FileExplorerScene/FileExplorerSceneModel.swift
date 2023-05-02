//
//  FileExplorerSceneModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Модель сцены файлового менеджера.
enum FileExplorerSceneModel {

	struct Response {
		let directoryPath: String
		let directoryObjects: [DirectoryObject]
	}

	struct ViewData {

		struct DirectoryObjectViewModel {
			let name: String
			let image: ImageAsset
		}

		let title: String
		var objectViewModels: [DirectoryObjectViewModel]
	}
}
