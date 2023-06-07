//
//  EditFileSceneViewController.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 29.04.2023.
//

import UIKit
import SnapKit

/// Вью контроллер сцены редактирования файла.
protocol IEditFileSceneViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: EditFileSceneModel.ViewData)
}

/// Вью контроллер сцены редактирования файла.
final class EditFileSceneViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IEditFileSceneInteractor
	private var viewData = EditFileSceneModel.ViewData(attributedText: NSAttributedString())
	private lazy var textView: UITextView = {
		let label = UITextView()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		return label
	}()

	// MARK: - Lifecycle

	init(interactor: IEditFileSceneInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupLayout()
		interactor.fetchData()
	}
}

// MARK: - IEditFileSceneViewController

extension EditFileSceneViewController: IEditFileSceneViewController {

	func render(viewData: EditFileSceneModel.ViewData) {
		textView.attributedText = viewData.attributedText
	}
}

// MARK: - Private methods

private extension EditFileSceneViewController {

	func setupUI() {
		view.addSubview(textView)
	}

	func setupLayout() {
		textView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}
