//
//  IVisitor.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Посетитель, преобразующий узлы в текст в формате `NSMutableAttributedString`.
protocol IVisitor {
	func visit(node: Document) -> NSMutableAttributedString
	func visit(node: HeaderNode) -> NSMutableAttributedString
	func visit(node: CiteNode) -> NSMutableAttributedString
	func visit(node: ParagraphNode) -> NSMutableAttributedString
	func visit(node: TextNode) -> NSMutableAttributedString
	func visit(node: BoldTextNode) -> NSMutableAttributedString
	func visit(node: LineBreakNode) -> NSMutableAttributedString
	func visit(node: ImageNode) -> NSMutableAttributedString
	func visit(node: UnorderedListItemNode) -> NSMutableAttributedString
}

extension IVisitor {

	func visitChildren(_ node: INode) -> [NSMutableAttributedString] {
		node.children.compactMap { child in
			switch child {
			case let child as Document:
				return visit(node: child)
			case let child as HeaderNode:
				return visit(node: child)
			case let child as CiteNode:
				return visit(node: child)
			case let child as ParagraphNode:
				return visit(node: child)
			case let child as TextNode:
				return visit(node: child)
			case let child as BoldTextNode:
				return visit(node: child)
			case let child as LineBreakNode:
				return visit(node: child)
			case let child as ImageNode:
				return visit(node: child)
			case let child as UnorderedListItemNode:
				return visit(node: child)
			default:
				return nil
			}
		}
	}
}

extension Sequence where Iterator.Element == NSMutableAttributedString {

	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}
