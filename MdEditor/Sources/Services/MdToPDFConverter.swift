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

/// Класс реализации конвертера файлов .md в формат pdf.
final class MdToPDFConverter: IMdToPDFConverter {

	// MARK: - Private properties

	private let lexer = Markdown.Lexer()
	private let parser = Markdown.Parser()

	private enum Constants {
		static let pageX: Double = 10
		static let pageY: Double = 10
		static let pageWidth: Double = 595.2
		static let pageHeight: Double = 841.8

		static let cursorSize: CGFloat = 40
		static let cursorIndent: CGFloat = 24.0
		static let cursorSizeUpdate: CGFloat = 24
	}

	// MARK: IMdToPDFConverter

	func convert(text: String, pdfAuthor: String, pdfTitle: String) -> Data {
		let tokens = lexer.tokenize(input: text)
		let document = parser.parse(tokens: tokens)

		let visitor = AttributedTextVisitor()
		let lines = document.accept(visitor: visitor)

		let pdfMetaData = [
			kCGPDFContextAuthor: pdfAuthor,
			kCGPDFContextTitle: pdfTitle
		]

		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]

		let pageRect = CGRect(
			x: Constants.pageX,
			y: Constants.pageY,
			width: Constants.pageWidth,
			height: Constants.pageHeight
		)
		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor: CGFloat = Constants.cursorSize

			lines.forEach { line in
				cursor = context.addAttributedText(
					text: line,
					indent: Constants.cursorIndent,
					cursor: cursor,
					pdfSize: pageRect.size
				)

				cursor += Constants.cursorSizeUpdate
			}
		}

		return data
	}
}
