//
//  AttributedTextVisitor.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation
import UIKit

/// Посетитель, преобразующий узлы в текст в формате `NSMutableAttributedString`.
final class AttributedTextVisitor: IVisitor {

	func visit(node: Document) -> NSMutableAttributedString {
		visitChildren(node).joined()
	}

	func visit(node: HeaderNode) -> NSMutableAttributedString {
		let text = visitChildren(node).joined()
		let sizes: [CGFloat] = [32, 30, 28, 26, 24, 22, 20]

		text.addAttribute(.font, value: UIFont.systemFont(ofSize: sizes[node.level]), range: NSRange(0..<text.length))
		text.append(NSMutableAttributedString(string: "\n"))
		return text
	}

	func visit(node: ImageNode) -> NSMutableAttributedString {
		let imageAttachment = NSTextAttachment()
		imageAttachment.image = UIImage(named: node.url)
		imageAttachment.bounds = CGRect(x: 0, y: 0, width: Int(node.size) ?? 200, height: Int(node.size) ?? 200)

		let imageString = NSMutableAttributedString(attachment: imageAttachment)

		return imageString
	}

	func visit(node: CiteNode) -> NSMutableAttributedString {
		let text = visitChildren(node).joined()
		text.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 18), range: NSRange(0..<text.length))
		text.append(NSMutableAttributedString(string: "\n"))
		return text
	}

	func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let text = visitChildren(node).joined()
		text.append(NSMutableAttributedString(string: "\n"))
		return text
	}

	func visit(node: TextNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 18)
		]
		return NSMutableAttributedString(string: node.text, attributes: attributes)
	}

	func visit(node: BoldTextNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.boldSystemFont(ofSize: 18)
		]
		return NSMutableAttributedString(string: node.text, attributes: attributes)
	}

	func visit(node: LineBreakNode) -> NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}

	func visit(node: UnorderedListItemNode) -> NSMutableAttributedString {
		let markerAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 10)
		]
		let inset = String(repeating: "  ", count: node.level)
		let text = NSMutableAttributedString(string: inset + "● ", attributes: markerAttributes)
		text.append(visitChildren(node).joined())
		text.append(NSMutableAttributedString(string: "\n"))
		return text
	}
}
