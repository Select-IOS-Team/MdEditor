//
//  NSRegularExpression+Extension.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 06.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension NSRegularExpression {
	func match(_ text: String) -> Bool {
		let range = NSRange(text.startIndex..., in: text)
		return firstMatch(in: text, range: range) != nil
	}
}
