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

	struct Response {
		let pdfData: Data
	}

	struct ViewData {
		let pdfData: Data
	}
}
