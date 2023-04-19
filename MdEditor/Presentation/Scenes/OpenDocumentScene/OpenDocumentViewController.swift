//
//  OpenDocumentViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit
import SnapKit

/// Вью контроллер сцены выбора файлов и папок.
protocol IOpenDocumentViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: [OpenDocumentModel.OpenDocumentViewData.FileViewModel])
}

/// Вью контроллер сцены выбора файлов и папок.
class OpenDocumentViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IOpenDocumentInteractor?
	private lazy var tableView = makeTableView()

	// MARK: - Internal properties

	var viewData: [OpenDocumentModel.OpenDocumentViewData.FileViewModel] = []

	// MARK: - Lifecycle

	init(interactor: IOpenDocumentInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.fetchFileStruct()
	}
}

// MARK: - UITableViewDataSource

extension OpenDocumentViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeue(
			type: FileTableViewCell.self,
			for: indexPath
		) else { return UITableViewCell() }

		let model = viewData[indexPath.row]
		cell.configure(with: model)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension OpenDocumentViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.interactor?.didCellTapped(indexPath: indexPath)
	}
}

// MARK: - IOpenDocumentViewController

extension OpenDocumentViewController: IOpenDocumentViewController {

	func render(viewData: [OpenDocumentModel.OpenDocumentViewData.FileViewModel]) {
		self.viewData = viewData
		tableView.reloadData()
	}
}

// MARK: - Private methods

private extension OpenDocumentViewController {

	func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.registerCell(type: FileTableViewCell.self)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}

	func setupUI() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make -> Void in
			make.width.equalToSuperview()
			make.height.equalToSuperview()
		}
	}
}
