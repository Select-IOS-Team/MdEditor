//
//  UnorderedListItemNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел ненумерованного списка.
final class UnorderedListItemNode: BaseNode {

	let level: Int

	init(level: Int, children: [INode]) {
		self.level = level
		super.init(children)
	}
}

extension UnorderedListItemNode: IVisitable {

	func accept(visitor: IVisitor) -> NSMutableAttributedString {
		visitor.visit(node: self)
	}
}
