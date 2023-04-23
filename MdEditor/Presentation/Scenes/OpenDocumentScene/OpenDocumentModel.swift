//
//  OpenDocumentModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Модель вью
enum OpenDocumentModel {

	struct OpenDocumentViewData {

		struct DirectoryObjectViewModel {

			let name: String
			let image: ImageAsset
			let fullName: String
			let menuItem: DirectoryObjectType
		}

		enum DirectoryObjectType {
			case folder
			case document
		}
		let title: String
		var objectsViewModel: [DirectoryObjectViewModel]
	}
}
