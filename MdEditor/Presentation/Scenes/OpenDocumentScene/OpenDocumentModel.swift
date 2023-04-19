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
		struct FileViewModel: Equatable {
			let fileTitle: String
			let fileImageName: String
		}
		let filesViewModel: [FileViewModel]
	}
}
