//
//  BrowseHTMLModel.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Модель сцены просмотра html-файла.
enum BrowseHTMLModel {

	struct Response {
		let text: String
		let htmlText: String
	}

	struct ViewData {
		let text: String
		let htmlText: String
	}
}
