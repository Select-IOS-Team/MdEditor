//
//  Text.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 11.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension Markdown {

	struct Text {
		let text: [Part]

		enum Part {
			case boldItalic(text: String)
			case bold(text: String)
			case italic(text: String)
			case normal(text: String)
			case inlineCode(code: String)
			case escapedChar(char: String)
		}

		init(text: [Part]) {
			self.text = text
		}

	}

}
