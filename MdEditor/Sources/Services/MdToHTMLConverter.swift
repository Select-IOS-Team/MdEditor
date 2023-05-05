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
		""
	}

}

// MARK: Private methods

private extension MdToHTMLConverter {

	func parseParagraph(text: String) -> String? {
		""
	}

	func parseHeader(text: String) -> String? {
		""
	}
}

private enum RegexPatterns {
	// Абзац
	static let paragraph = #"^(#|&gt;)"#
	// Заголовок
	static let header = #"^#{1,6} "#
	// Нумерованный список
	static let numberedList = #"(\d\.|\t\d\.?|\t\*?|\*|\-|\+)\s?(.*)"#
	// Список без нумерации
	static let unorderedList = ""
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
	static let quote = #"^&gt; (.*)"#
	// Встроенный блок кода
	static let inlineCodeBlock = #"\`{1}([^\`]+)\`{1}"#
	// Многострочный блок кода
	static let multilineCodeBlock = #"\`{3}(\w+)?\n([^\`]+)\n\`{3}"#
	// Горизонтальная линия
	static let horizontalLine = ""
}
