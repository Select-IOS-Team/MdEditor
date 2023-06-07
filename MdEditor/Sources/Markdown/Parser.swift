//
//  Parser.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

extension Markdown {

	final class Parser {

		// MARK: - Internal methods

		func parse(tokens: [Token]) -> Document {
			var tokens = tokens
			var result = [INode]()

			while !tokens.isEmpty {
				var nodes = [INode?]()
				nodes.append(parseHeader(tokens: &tokens))
				nodes.append(parseCite(tokens: &tokens))
				nodes.append(parseParagraph(tokens: &tokens))
				nodes.append(parseImage(tokens: &tokens))
				nodes.append(parseLineBreak(tokens: &tokens))
				nodes.append(parseUnorderedList(tokens: &tokens))
				let resultNodes = nodes.compactMap { $0 }

				result.append(contentsOf: resultNodes)
			}

			return Document(result)
		}

		func parseHeader(tokens: inout [Token]) -> HeaderNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .header(level, text) = token {
				tokens.removeFirst()
				let textNode = parseText(token: text)
				return HeaderNode(level: level, children: textNode)
			}

			return nil
		}

		func parseCite(tokens: inout [Token]) -> CiteNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .cite(level, text) = token {
				tokens.removeFirst()
				let textNode = parseText(token: text)
				return CiteNode(level: level, children: textNode)
			}

			return nil
		}

		func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
			var textNodes = [INode]()

			while !tokens.isEmpty {
				guard let token = tokens.first else {
					return nil
				}
				print(token)

				if case let .text(text) = token {
					tokens.removeFirst()
					textNodes.append(contentsOf: parseText(token: text))
				} else if case .lineBreak = token {
					tokens.removeFirst()
					break
				} else {
					break
				}
			}

			if textNodes.isEmpty {
				return nil
			} else {
				return ParagraphNode(textNodes)
			}
		}

		func parseImage(tokens: inout [Token]) -> ImageNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .image(url, size) = token {
				tokens.removeFirst()
				return ImageNode(url: url, size: size)
			}

			return nil
		}

		func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case .lineBreak = token {
				tokens.removeFirst()
				return LineBreakNode()
			}

			return nil
		}

		func parseUnorderedList(tokens: inout [Token]) -> UnorderedListItemNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .unorderedListItem(level: level, text: text) = token {
				tokens.removeFirst()
				let textNode = parseText(token: text)
				return UnorderedListItemNode(level: level, children: textNode)
			}

			return nil
		}
	}
}

// MARK: - Private methods

private extension Markdown.Parser {

	func parseText(token: Markdown.Text) -> [INode] {
		var textNodes = [INode]()

		token.text.forEach { part in
			switch part {
			case .boldItalic(let text):
				textNodes.append(BoldTextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .normal(let text):
				textNodes.append(TextNode(text: text))
			case .inlineCode(let code):
				textNodes.append(InlineCodeNode(code: code))
			case .escapedChar(let char):
				textNodes.append(EscapedCharNode(char: char))
			}
		}
		return textNodes
	}
}
