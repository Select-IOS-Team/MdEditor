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
			let title: String
			let imageName: String
			let name: String
			let fullName: String
			let menuItem: DirectoryObjectType
		}

		enum DirectoryObjectType {
			case folder
			case document
		}

		let objectsViewModel: [DirectoryObjectViewModel]
	}
}
