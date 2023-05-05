//
//  MdToHTMLConverter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

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
		""
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
		""
	}

	func parseUnorderedList(text: String) -> String? {
		""
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
		""
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
}

private enum RegexPatterns {
	// Абзац
	static let paragraph = #"^[^\S\r\n]*#[^#\S\r\n]*([^#\s]+.*)"#
	// Заголовок
	static let header = #"^#{1,6} "#
	// Нумерованный список
	static let numberedList = #"^[0-9]+[ .][\s\S]*?\n{2}"#
	// Список без нумерации
	static let unorderedList = #"^[*+-]+[ .][\s\S]*?\n{2}"#
	// Ссылка в md файле
	static let referenceMd = #"\[(.+)\]\((.+)\)"#
	// Ссылка
	static let reference = #"[-a-zA-Z0-9@:%_\+.~#?&\/\/=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?"#
	// Жирный текст
	static let boldText = #"\*\*(.*?)\*\*"#
	// Наклонный текст
	static let italicText = #"\*(.*?)\*"#
	// Жирный наклонный текст
	static let boldItalicText = #"\*\*\*(.*?)\*\*\*"#
	// Цитата
	static let quote = #"/(?:^>.+\n)+/m"#
	// Встроенный блок кода
	static let inlineCodeBlock = #"\`{1}([^\`]+)\`{1}"#
	// Многострочный блок кода
	static let multilineCodeBlock = #"\`{3}(\w+)?\n([^\`]+)\n\`{3}"#
	// Горизонтальная линия
	static let horizontalLine = #"\-{3}"#
}
