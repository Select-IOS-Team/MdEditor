//
//  NSRegularExpression+Extension.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 06.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension NSRegularExpression {

	/// Определяет наличие совпадения регулярного выражения в указанном диапазоне строки.
	/// - Parameter `Text`: Переданная строка.
	/// - Returns `Bool`: Имеется совпадение или нет.
	func match(_ text: String) -> Bool {
		let range = NSRange(text.startIndex..., in: text)
		return firstMatch(in: text, range: range) != nil
	}
}
