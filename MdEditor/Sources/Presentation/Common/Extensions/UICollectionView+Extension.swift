//
//  UICollectionView+Extension.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 19.04.2023.
//

import UIKit

extension UICollectionView {

	/// Регистрирует класс ячейки.
	/// - Parameter type: Регистрируемый класс.
	func registerCell<T: UICollectionViewCell>(type: T.Type) {
		register(type, forCellWithReuseIdentifier: String(describing: type))
	}

	/// Возвращает переиспользуемый объект ячейки UICollectionView для указанного типа ячейки.
	/// - Parameters:
	///   - type: Тип ячейки.
	///   - indexPath: IndexPath ячейки.
	/// - Returns: Переиспользуемый объект ячейки.
	func dequeue<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T? {
		dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T
	}
}
