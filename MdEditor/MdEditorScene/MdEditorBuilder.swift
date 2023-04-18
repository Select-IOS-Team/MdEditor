//
//  MdEditorBuilder.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Класс сборщика
enum MdEditorBuilder {
	static func build() -> MdEditorViewController {

		let mdEditorWorker: IMdEditorWorker = MdEditorWorker()
		let mdEditorPresenter = MdEditorPresenter()
		let mdEditorInteractor = MdEditorInteractor(
			presenter: mdEditorPresenter,
			worker: mdEditorWorker
		)
		let mdEditorViewController = MdEditorViewController(interactor: mdEditorInteractor)
		mdEditorPresenter.viewController = mdEditorViewController

		return mdEditorViewController
	}
}
