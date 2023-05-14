//
//  Lexer.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 11.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

extension Markdown {

	final class Lexer {
		func tokenize(input: String) -> [Token] {
			let lines = input.components(separatedBy: .newlines)
			var tokens = [Token?]()

			for line in lines {
				tokens.append(parseLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseQuote(rawText: line))
				tokens.append(parseNumberedList(rawText: line))
				tokens.append(parseUnorderedList(rawText: line))
				tokens.append(parseTextBlock(rawText: line))
			}

			return tokens.compactMap { $0 }
		}
		func tokenizeToString(tokens: [Token]) -> String {
			var tokensString = [String]()

			tokens.forEach { token in
				tokensString.append("")
			}
			return tokensString.joined(separator: "\n")
		}
	}

}

private extension Markdown.Lexer {
	func parseLineBreak(rawText: String) -> Markdown.Token? {
		if rawText.trimmingCharacters(in: .whitespaces).isEmpty {
			return .lineBreak
		}
		return nil
	}

	func parseHeader(rawText: String) -> Markdown.Token? {
		if let header = rawText.range(of: Markdown.RegexPatterns.header, options: .regularExpression) {
			let text = parseText(rawText: String(rawText[header.upperBound...]))
			let level = rawText.filter { $0 == "#" }.count
			return .header(level: level, text: text)
		}
		return nil
	}

	func parseQuote(rawText: String) -> Markdown.Token? {
		if let text = rawText.group(for: Markdown.RegexPatterns.quote) {
			let level = rawText.filter { $0 == ">" }.count
			return .cite(level: level, text: parseText(rawText: text.trimmingCharacters(in: .whitespaces)))
		}
		return nil
	}

	func parseNumberedList(rawText: String) -> Markdown.Token? {
		if let text = rawText.group(for: Markdown.RegexPatterns.numberedList) {
			if let firstNotSpace = rawText.first(where: { $0 != " " }),
			   let firstNotSpaceIndex = rawText.firstIndex(of: firstNotSpace) {
				let level = rawText.distance(from: rawText.startIndex, to: firstNotSpaceIndex)
				return .numberedListItem(level: level, text: parseText(rawText: text))
			}
		}
		return nil
	}

	func parseUnorderedList(rawText: String) -> Markdown.Token? {
		if let text = rawText.group(for: Markdown.RegexPatterns.unorderedList) {
			if let firstNotSpace = rawText.first(where: { $0 != " " }),
			   let firstNotSpaceIndex = rawText.firstIndex(of: firstNotSpace) {
				let level = rawText.distance(from: rawText.startIndex, to: firstNotSpaceIndex)
				return .unorderedListItem(level: level, text: parseText(rawText: text))
			}
		}
		return nil
	}

	func parseTextBlock(rawText: String) -> Markdown.Token? {
		if rawText.isEmpty { return nil }
		let regex = try? NSRegularExpression(pattern: Markdown.RegexPatterns.notParagraph)
		if let notParagraph = regex?.match(rawText), notParagraph == true { return nil }
		return .text(text: parseText(rawText: rawText))
	}

	func parseText(rawText: String) -> Markdown.Text {
		return Markdown.Text(text: [.normal(text: rawText)])
	}
}

private extension Markdown.Lexer {

	struct PartRegex {

		let type: PartType
		let regex: NSRegularExpression

		enum PartType: String {
			case normal
			case bold
			case italic
			case boldItalic
			case inline
			case escapedChar
		}
		init(type: PartType, pattern: String) {
			self.type = type
			self.regex = try! NSRegularExpression(pattern: pattern)
		}
	}

	func parseText(text: String) -> Markdown.Text {
		let partRegexes = [
			PartRegex(type: .escapedChar, pattern: Markdown.RegexPatterns.escapedChar),
			PartRegex(type: .normal, pattern: Markdown.RegexPatterns.normal),
			PartRegex(type: .boldItalic, pattern: Markdown.RegexPatterns.boldItalicText),
			PartRegex(type: .bold, pattern: Markdown.RegexPatterns.boldText),
			PartRegex(type: .italic, pattern: Markdown.RegexPatterns.italicText),
			PartRegex(type: .inline, pattern: Markdown.RegexPatterns.inline)
		]

		var parts = [Markdown.Text.Part]()
		var range = NSRange(text.startIndex..., in: text)

		while range.location != NSNotFound && range.length != 0 {
			let startPartsCount = parts.count
			for partRegex in partRegexes {
				if let match = partRegex.regex.firstMatch(in: text, range: range),
				   let group0 = Range(match.range(at: 0), in: text),
				   let group1 = Range(match.range(at: 1), in: text)
				{
					let extractedText = String(text[group1])
					if !extractedText.isEmpty {
						switch partRegex.type {
						case .normal:
							parts.append(.normal(text: extractedText))
						case .boldItalic:
							parts.append(.boldItalic(text: extractedText))
						case .bold:
							parts.append(.bold(text: extractedText))
						case .italic:
							parts.append(.italic(text: extractedText))
						case .inline:
							parts.append(.inlineCode(code: extractedText))
						case .escapedChar:
							parts.append(.escapedChar(char: extractedText))
						}
						range = NSRange(group0.upperBound...,in: text)
						break
					}
				}
			}
			if parts.count == startPartsCount {
				if let range = Range(range, in: text) {
					let extractedText = String(text[range])
					parts.append(.normal(text: extractedText))
					break
				}
			}
		}
		return Markdown.Text(text: parts)
	}
}

fileprivate extension String {
	func indexOf(char: Character) -> Int? {
		return firstIndex(of: char)?.utf16Offset(in: self)
	}
}
