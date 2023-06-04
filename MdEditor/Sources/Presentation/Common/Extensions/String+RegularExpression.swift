//
//  String+RegularExpression.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 06.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension String {

	/// Возвращает первую группу в найденном по шаблону тексте.
	/// - Parameter regexPattern: Переданная строка текста.
	/// - Returns `String`:  Строка, содержащая только подстроку из группы.
	func group(for regexPattern: String) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)

			if let match = regex.firstMatch(in: text, options: [], range: range),
			   let group = Range(match.range(at: 1), in: text) {
				return String(text[group])
			}
		} catch {
			return nil
		}
		return nil
	}

	/// Возвращает найденный по шаблону тексте в виде массива групп.
	/// - Parameter regexPattern: Переданная строка текста.
	/// - Returns `[[String]]`:  Массив, содержащий в себе группы в найденном тексте.
	func groups(for regexPattern: String) -> [[String]] {
		let text = self as NSString
		let range = NSRange(location: .zero, length: text.length)
		let regex = try? NSRegularExpression(pattern: regexPattern, options: [])

		let result = regex?.matches(in: self, options: [], range: range).map { match in
			(1..<match.numberOfRanges).compactMap {
				match.range(at: $0).location == NSNotFound ? nil : text.substring(with: match.range(at: $0))
			}
		} ?? []

		return result
	}

	/// Возвращает строку без начального и конечного символов.
	/// - Returns `String`:  Строка без начального и конечного символов.
	func removeLeftRightSymbols() -> String {
		let start = self.index(self.startIndex, offsetBy: 1)
		let end = self.index(self.endIndex, offsetBy: -1)
		let range = start..<end
		return String(self[range])
	}
}
