//
//  AttributedTextExporter.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Объект, производящий экспорт документа в подготовленный для отображения формат текста.
final class AttributedTextExporter {

	// MARK: - Private properties

	private let visitor = AttributedTextVisitor()

	// MARK: - Internal methods

	/// Экспорт данных из объекта `Document` в `NSMutableAttributedString`.
	/// - Parameter document: Документ.
	func export(document: Document) -> NSMutableAttributedString {
		document.accept(visitor: visitor)
	}
}
