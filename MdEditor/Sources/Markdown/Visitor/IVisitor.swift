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
	associatedtype Result

	func visit(node: Document) -> [Result]
	func visit(node: HeaderNode) -> Result
	func visit(node: CiteNode) -> Result
	func visit(node: ParagraphNode) -> Result
	func visit(node: TextNode) -> Result
	func visit(node: BoldTextNode) -> Result
	func visit(node: LineBreakNode) -> Result
	func visit(node: ImageNode) -> Result
	func visit(node: UnorderedListItemNode) -> Result
}

extension IVisitor {

	func visitChildren(_ node: INode) -> [Result] {
		node.children.compactMap { child in
			switch child {
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
