//
//  InlineCodeNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел кода внутри текста.
final class InlineCodeNode: BaseNode {

	let code: String

	init(code: String) {
		self.code = code
	}
}
