//
//  Node.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел, используемый при парсинге текста.
protocol INode {
	var children: [INode] {get}
}

/// Базовый узел.
class BaseNode: INode {
	private(set) var children: [INode]

	init(_ children: [INode] = []) {
		self.children = children
	}
}
