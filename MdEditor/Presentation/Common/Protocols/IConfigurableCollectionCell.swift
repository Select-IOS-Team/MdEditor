//
//  IConfigurableCollectionCell.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 19.04.2023.
//

import UIKit

/// Конфигурируемая ячейка коллекции.
protocol IConfigurableCollectionCell: UICollectionViewCell {
	associatedtype ConfigurationModel

	/// Конфигурирует ячейку.
	/// - Parameter model: Конфигурационная модель данных ячейки.
	func configure(with model: ConfigurationModel)
}
