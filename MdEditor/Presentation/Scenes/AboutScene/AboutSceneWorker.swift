//
//  AboutSceneWorker.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import Foundation

/// Воркер подготавливающий вью модель
protocol IAboutSceneWorker {
	func prepareViewModel(data: DirectoryObject) -> AboutSceneModel.ViewData
}

/// Класс воркера
class AboutSceneWorker: IAboutSceneWorker {

	// MARK: - Internal Methods

	func prepareViewModel(data: DirectoryObject) -> AboutSceneModel.ViewData {
		let response = AboutSceneModel.ViewData(information: data.getFileText(fullPath: data.path))
		return response
	}
}
