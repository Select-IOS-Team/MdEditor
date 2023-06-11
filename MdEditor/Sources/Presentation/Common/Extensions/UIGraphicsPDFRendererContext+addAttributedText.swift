//
//  UIGraphicsPDFRendererContext+addAttributedText.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import PDFKit

extension UIGraphicsPDFRendererContext {
	func addAttributedText(
		text: NSAttributedString,
		indent: CGFloat,
		cursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		let pdfTextHeight = text.height(withConstrainedWidth: pdfSize.width - 2 * indent)

		let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2 * indent, height: pdfTextHeight)
		text.draw(in: rect)

		return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
	}

	// swiftlint:disable all
	func checkContext(cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		if cursor > pdfSize.height - 100 {
			self.beginPage()
			return 40
		}
		return cursor
	}
	// swiftlint:enable all
}
