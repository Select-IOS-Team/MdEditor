//
//  BrowsePDFModel.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Модель данных `BrowsePDFModel`.
enum BrowsePDFModel {

	/// Запрос данных для `BrowsePDF`.
	struct Response {
		let text: String
		let pdfData: Data
	}

	/// Модель передачи данных для `BrowsePDF`.
	struct ViewData {
		let text: String
		let pdfData: Data
	}
}
