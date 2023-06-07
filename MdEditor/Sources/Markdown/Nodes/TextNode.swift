//
//  TextNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел обычного текста.
final class TextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

/// Узел полужирного наклонного текста.
final class BoldItalicTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

/// Узел полужирного текста.
final class BoldTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

/// Узел наклонного текста.
final class ItalicTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}
