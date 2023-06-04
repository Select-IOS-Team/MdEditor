//
//  EscapedCharNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

final class EscapedCharNode: BaseNode {

	let char: String

	init(char: String) {
		self.char = char
	}
}
