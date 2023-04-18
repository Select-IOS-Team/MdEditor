//
//  MdEditorInteractor.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Интерактор сцены меню текстового редактора
protocol IMdEditorInteractor: AnyObject {

}

/// Класс интерактора
class MdEditorInteractor: IMdEditorInteractor {

	private let presenter: IMdEditorPresenter?
	private let worker: IMdEditorWorker?

	init(presenter: IMdEditorPresenter, worker: IMdEditorWorker) {
		self.presenter = presenter
		self.worker = worker
	}
}
