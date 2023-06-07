//
//  MarkdownTextParser.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 05.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

protocol IMarkdownTextParser {
	func parse(_ markdownText: String) -> NSAttributedString
}

final class MarkdownTextParser: IMarkdownTextParser {

	// MARK: - Private properties

	private let lexer: Markdown.Lexer
	private let parser: Markdown.Parser
	private let attributedTextExporter: AttributedTextExporter

	// MARK: - Lificycle

	init(
		lexer: Markdown.Lexer,
		parser: Markdown.Parser,
		attributedTextExporter: AttributedTextExporter
	) {
		self.lexer = lexer
		self.parser = parser
		self.attributedTextExporter = attributedTextExporter
	}

	// MARK: - IMarkdownFileLoader

	func parse(_ markdownText: String) -> NSAttributedString {
		let tokens = lexer.tokenize(input: markdownText)
		let document = parser.parse(tokens: tokens)
		return attributedTextExporter.export(document: document)
	}
}
