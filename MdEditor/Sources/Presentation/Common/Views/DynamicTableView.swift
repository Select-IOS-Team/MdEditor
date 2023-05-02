//
//  DynamicTableView.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 19.04.2023.
//

import UIKit

/// TableView, динамический меняющая свой размер под размер контента.
final class DynamicTableView: UITableView {

	override func layoutSubviews() {
		super.layoutSubviews()
		if bounds.size != intrinsicContentSize {
			invalidateIntrinsicContentSize()
		}
	}

	override var intrinsicContentSize: CGSize {
		contentSize
	}

	override func reloadData() {
		super.reloadData()
		layoutIfNeeded()
	}
}
