//
//  TextNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

final class TextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

final class BoldItalicTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

final class BoldTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}

final class ItalicTextNode: BaseNode {

	let text: String

	init(text: String) {
		self.text = text
	}
}
