//
//  ImageNode.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Узел картинки.
final class ImageNode: BaseNode {

	let url: String
	let size: String

	init(url: String, size: String) {
		self.url = url
		self.size = size
		super.init()
	}
}
