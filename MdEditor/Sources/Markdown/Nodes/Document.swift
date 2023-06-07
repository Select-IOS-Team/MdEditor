//
//  Document.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел документа.
final class Document: BaseNode {}

extension Document: IVisitable {

	func accept(visitor: IVisitor) -> NSMutableAttributedString {
		visitor.visit(node: self)
	}
}
