//
//  Token.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 11.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension Markdown {

	enum Token: CustomStringConvertible {

		var description: String {
			return ""
		}

		case header(level: Int, text: Text)
		case cite(level: Int, text: Text)
		case text(text: Text)
		case numberedListItem(level: Int, text: Text)
		case unorderedListItem(level: Int, text: Text)
		case link(url: String, text: String)
		case image(url: String, text: String)
		case lineBreak
		case codeBlockMarker(level: Int, lang: String)
		case codeLine(text: String)
	}
}
