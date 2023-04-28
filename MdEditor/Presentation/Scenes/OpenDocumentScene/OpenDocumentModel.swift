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

		enum DirectoryObjectType {
			case folder
			case document
		}

		struct DirectoryObjectViewModel {

			let name: String
			let image: ImageAsset
			let fullName: String
			let menuItem: DirectoryObjectType
		}

		let title: String
		var objectsViewModel: [DirectoryObjectViewModel]
	}
}
