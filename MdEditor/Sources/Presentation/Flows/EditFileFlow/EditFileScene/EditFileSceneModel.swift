//
//  EditFileSceneModel.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import Foundation

/// Модель сцены редактирования файла.
enum EditFileSceneModel {

	struct Response {
		let attributedText: NSAttributedString
	}

	struct ViewData {
		let attributedText: NSAttributedString
	}
}
