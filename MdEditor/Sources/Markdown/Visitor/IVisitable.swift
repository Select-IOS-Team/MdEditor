//
//  IVisitable.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 04.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Объект, умеющий принимать посетителей преобразующих узлы в текст в формате `NSMutableAttributedString`.
protocol IVisitable {
	/// Принятие посетителя для преобразования данных.
	/// - Parameter visitor: Посетитель.
	/// - Returns: Текст в формате `NSMutableAttributedString`.
	func accept(visitor: IVisitor) -> NSMutableAttributedString
}
