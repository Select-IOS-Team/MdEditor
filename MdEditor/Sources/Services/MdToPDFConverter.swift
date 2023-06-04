//
//  MdToPDFConverter.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation
import PDFKit
import UIKit

/// Конвертер файлов .md в формат pdf.
protocol IMdToPDFConverter {
	/// Конвертирует текст в формат pdf.
	/// - Parameters:
	///   - text: Текст из md-файла.
	///   - pdfAuthor: Автор pdf-документа.
	///   - pdfTitle: Заголовок pdf-документа.
	/// - Returns:
	///   - Данные для формирования pdf-документа в формате Data.
	func convert(text: String, pdfAuthor: String, pdfTitle: String) -> Data
}

// Заглушка.
private class Parser {
	// Заглушка.
	func parse(tokens: [Markdown.Token]) -> Document {
		Document()
	}
}

// Заглушка.
private class Visitor: IVisitor {
	// Заглушка.
	func visit(node: Document) -> [NSMutableAttributedString] {
		[NSMutableAttributedString()]
	}
}

protocol IVisitor {
	// Заглушка.
	associatedtype Result
	// Заглушка.
	func visit(node: Document) -> [Result]
}

// Заглушка.
class Document {
	// Заглушка.
	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: Document())
	}
}

/// Класс реализации конвертера файлов .md в формат pdf.
final class MdToPDFConverter: IMdToPDFConverter {
	private let lexer = Markdown.Lexer()
	private let parser = Parser()

	/// Конвертирует текст в формат pdf.
	/// - Parameters:
	///   - text: Текст из md-файла.
	///   - pdfAuthor: Автор pdf-документа.
	///   - pdfTitle: Заголовок pdf-документа.
	/// - Returns:
	///   - Данные для формирования pdf-документа в формате Data.
	func convert(text: String, pdfAuthor: String, pdfTitle: String) -> Data {
		let tokens = lexer.tokenize(input: text)
		let document = parser.parse(tokens: tokens)

		let visitor = Visitor()
		let lines = document.accept(visitor: visitor)

		let pdfMetaData = [
			kCGPDFContextAuthor: pdfAuthor,
			kCGPDFContextTitle: pdfTitle
		]

		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]

		let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor: CGFloat = 40

			lines.forEach { line in
				cursor = context.addAttributedText(
					text: line,
					indent: 24.0,
					cursor: cursor,
					pdfSize: pageRect.size
				)

				cursor += 24
			}
		}

		return data
	}
}
