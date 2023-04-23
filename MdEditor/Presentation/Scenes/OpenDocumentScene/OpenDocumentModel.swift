//
//  OpenDocumentModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Модель вью
enum OpenDocumentModel {
	struct OpenDocumentViewData: Equatable {
		struct DirectoryObjectViewModel: Equatable {
			let name: String
			let imageName: String
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
