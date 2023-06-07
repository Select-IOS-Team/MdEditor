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
			html.append(parseUnorderedList(text: htmlLine))
			html.append(parseNumberedList(text: htmlLine))
			html.append(parseParagraph(text: htmlLine))
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
		let regex = try? NSRegularExpression(pattern: Markdown.RegexPatterns.paragraph)
		if let noParagraph = regex?.match(text), noParagraph == true { return nil }
		let parsedText = parseText(text: text)
		return "<p>\(parsedText)</p>"
	}

	func parseHeader(text: String) -> String? {
		if let headerRange = text.range(of: Markdown.RegexPatterns.header, options: .regularExpression) {
			let headerText = text[headerRange.upperBound...]
			let headerLevel = text.filter { $0 == "#" }.count
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}
		return nil
	}

	func parseNumberedList(text: String) -> String? {
		if let range = text.range(of: Markdown.RegexPatterns.numberedList, options: .regularExpression) {
			let lineList = text[range.upperBound...]
			let text = parseText(text: "\(lineList)")
			return "<ol>\(text)</ol>"
		}
		return nil
	}

	func parseUnorderedList(text: String) -> String? {
		if let range = text.range(of: Markdown.RegexPatterns.unorderedList, options: .regularExpression) {
			let lineList = text[range.upperBound...]
			let text = parseText(text: "\(lineList)")
			return "<li>\(text)</li>"
		}
		return nil
	}

	func parseReferenceMd(text: String) -> String? {
		""
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
		let pattern = Markdown.RegexPatterns.quote
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
			of: Markdown.RegexPatterns.boldItalicText,
			with: "<strong><em>$1</em></strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: Markdown.RegexPatterns.boldText,
			with: "<strong>$1</strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: Markdown.RegexPatterns.italicText,
			with: "<em>$1</em>",
			options: .regularExpression
		)

		return result
	}
}
