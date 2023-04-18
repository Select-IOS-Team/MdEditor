//
//  MdEditorViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

/// Вью контроллер сцены меню текстового редактора.
protocol IMdEditorViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: MdEditorModel.ViewData)
}

/// Вью контроллер сцены меню текстового редактора.
class MdEditorViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IMdEditorInteractor?

	// MARK: - Internal properties

	var viewData: MdEditorModel.ViewData = MdEditorModel.ViewData()

	// MARK: - Lifecycle

	init(interactor: IMdEditorInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
	}
}

// MARK: - IMdEditorViewController

extension MdEditorViewController: IMdEditorViewController {

	func render(viewData: MdEditorModel.ViewData) {
		self.viewData = viewData
	}
}
