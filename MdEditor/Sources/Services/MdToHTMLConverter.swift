//
//  MdToHTMLConverter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Конвертер файлов .md в формат html.
protocol IMdToHTMLConverter {
	/// Конвертирует текст в формат html.
	/// - Parameters:
	///   - text: Текст из md-файла.
	/// - Returns:
	///   - Строка в формате html.
	func convert(text: String) -> String
}

/// Конвертер файлов .md в формат html.
final class MdToHTMLConverter: IMdToHTMLConverter {

	// MARK: IMdToHTMLConverter

	func convert(text: String) -> String {
		let lines = text.components(separatedBy: .newlines)
		var html = [String?]()

		lines.forEach { line in
			let htmlLine = fixHtmlChar(text: line)
			html.append(parseHeader(text: htmlLine))
			html.append(parseQuote(text: htmlLine))
			html.append(parseParagraph(text: htmlLine))
			html.append(parseNumberedList(text: htmlLine))
			html.append(parseReferenceMd(text: htmlLine))
		}

		return insertToHTML(text: html.compactMap { $0 }.joined(separator: "\n"))
	}
}

// MARK: Private methods

private extension MdToHTMLConverter {

	func insertToHTML(text: String) -> String {
		return "<!DOCTYPE html><html><head><style> body {font-size:300%;}</style></head><boby>\(text)</boby></html>"
	}

	func fixHtmlChar(text: String) -> String {
		text
			.replacingOccurrences(of: "<", with: "&lt;")
			.replacingOccurrences(of: ">", with: "&gt;")
	}

	func parseParagraph(text: String) -> String? {
		let regex = try? NSRegularExpression(pattern: RegexPatterns.paragraph)
		if let noParagraph = regex?.match(text), noParagraph == true { return nil }
		let parsedText = parseText(text: text)
		return "<p>\(parsedText)</p>"
	}

	func parseHeader(text: String) -> String? {
		if let headerRange = text.range(of: RegexPatterns.header, options: .regularExpression) {
			let headerText = text[headerRange.upperBound...]
			let headerLevel = text.filter { $0 == "#" }.count
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}
		return nil
	}

	func parseNumberedList(text: String) -> String? {
		if let range = text.range(of: RegexPatterns.numberedList, options: .regularExpression) {
			let lineList = text[range.upperBound...]
			return "<li>\(lineList)</li>"
		}
		return nil
	}

	func parseUnorderedList(text: String) -> String? {
		""
	}

	func parseReferenceMd(text: String) -> String? {
////		<a href="url">link text</a>
//		if let range = text.range(of: RegexPatterns.referenceMd, options: .regularExpression) {
////			let ref = text[range.lowerBound...]
//			let structURL = ParseURL.parse(rawValue: text, pattern: RegexPatterns.referenceMd)
//			let aaa = 0
////			// return "<a href=\(ref)</a>"
////			return "<a href=https://example.com</a>"
//		}
////		return nil
		return ""
	}

	func parseBoldText(text: String) -> String? {
		""
	}

	func parseItalicText(text: String) -> String? {
		""
	}

	func parseBoldItalicText(text: String) -> String? {
		""
	}

	func parseQuote(text: String) -> String? {
		let pattern = RegexPatterns.quote
		if let citeText = text.group(for: pattern) {
			return "<cite>\(citeText)</cite>"
		}
		return nil
	}

	func parseInlineCodeBlock(text: String) -> String? {
		""
	}

	func parseMultilineCodeBlock(text: String) -> String? {
		""
	}

	func parseHorizontalLine(text: String) -> String? {
		""
	}

	func parseText(text: String) -> String {
		var result = text.replacingOccurrences(
			of: RegexPatterns.boldItalicText,
			with: "<strong><em>$1</em></strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: RegexPatterns.boldText,
			with: "<strong>$1</strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: RegexPatterns.italicText,
			with: "<em>$1</em>",
			options: .regularExpression
		)

		return result
	}
}

private enum RegexPatterns {
	// Абзац
//	static let paragraph = #"^[^\S\r\n]*#[^#\S\r\n]*([^#\s]+.*)"#
	static let paragraph = #"^(#|&gt;)"#
	// Заголовок
	static let header = #"^#{1,6} "#
	// Нумерованный список
	// static let numberedList = #"^[0-9]+[ .][\s\S]*?\n{2}"#
	static let numberedList = #"^(\n|\t|\r)?\d+\. "#
	// Список без нумерации
	static let unorderedList = #"^[*+-]+[ .][\s\S]*?\n{2}"#
	// Ссылка в md файле
	// static let referenceMd = #"\[(.+)\]\((.+)\)"#
	// static let referenceMd = #"(\[((?:\[[^\]]*\]|[^\[\]])*)\]\([ \t]*()
	// <?((?:\([^)]*\)|[^()\s])*?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))"#
	// static let referenceMd = #"\[[^\[\]]*?\]\(.*?\)|^\[*?\]\(.*?\)"#
	static let referenceMd = #"(?<header>\[[^\[\]]*?\])(?<link>\(.*?\)|^\[*?\]\(.*?\))"#
	// Ссылка
	static let reference = #"[-a-zA-Z0-9@:%_\+.~#?&\/\/=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?"#
	// Жирный текст
	static let boldText = #"\*\*(.*?)\*\*"#
	// Наклонный текст
	static let italicText = #"\*(.*?)\*"#
	// Жирный наклонный текст
	static let boldItalicText = #"\*\*\*(.*?)\*\*\*"#
	// Цитата
//	static let quote = #"/(?:^>.+\n)+/m"#
	static let quote = #"^&gt; (.*)"#
	// Встроенный блок кода
	static let inlineCodeBlock = #"\`{1}([^\`]+)\`{1}"#
	// Многострочный блок кода
	static let multilineCodeBlock = #"\`{3}(\w+)?\n([^\`]+)\n\`{3}"#
	// Горизонтальная линия
	static let horizontalLine = #"\-{3}"#
}
