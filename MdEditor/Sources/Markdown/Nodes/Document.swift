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

extension Document {

	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: self)
	}
}
