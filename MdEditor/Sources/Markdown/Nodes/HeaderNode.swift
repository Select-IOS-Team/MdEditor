//
//  HeaderNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел заголовка.
final class HeaderNode: BaseNode {

	let level: Int

	init(level: Int, children: [INode]) {
		self.level = level
		super.init(children)
	}
}
