//
//  RegexPatterns.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 11.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension Markdown {

	enum RegexPatterns {
		// Абзац
		static let paragraph = #"^(#|&gt;)"#
		static let notParagraph = #"^[#>]"#
		// Заголовок
		static let header = #"^#{1,6} "#
		// Нумерованный список
		static let numberedList = #"^([ \t]*)[\d]+\.\s+(.*)"#
		// Список без нумерации
		static let unorderedList = #"^([ \t]*)-\s+(.*)"#
		// Ссылка в md файле
		static let referenceMd = #"((\s|^)\[[^\[\]]*?\])(\(.*?\)|^\[*?\]\(.*?\))"#
		// Изображение
		static let imageMd = #"(!\[[^\[\]]*?\])(\(.*?\)|^\[*?\]\(.*?\))"#
		// Ссылка
		static let reference = #"[-a-zA-Z0-9@:%_\+.~#?&\/\/=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)?"#
		// Цитата
		static let quote = #"^>{1,6}(.*)"#
		// Встроенный блок кода
		static let inlineCodeBlock = #"\`{1}([^\`]+)\`{1}"#
		// Многострочный блок кода
		static let multilineCodeBlock = #"\`{3}(\w+)?\n([^\`]+)\n\`{3}"#
		static let multilineCodeBlockMarker = #"(^```\s{0,3})"#
		// Горизонтальная линия
		static let horizontalLine = #"\-{3}"#
		// Жирный текст
		static let boldText = #"^\*\*(.*?)\*\*"#
		// Наклонный текст
		static let italicText = #"^\*(.*?)\*"#
		// Жирный наклонный текст
		static let boldItalicText = #"^\*\*\*(.*?)\*\*\*"#
		static let escapedChar = #"^\\([\\\`\*\_\{\}\[\]\<\>\(\)\+\-\.\!\|#]){1}"#
		static let normal = #"^(.*?)(?=[\*`\\]|$)"#
		static let inline = #"^`(.*?)`"#
	}
}
