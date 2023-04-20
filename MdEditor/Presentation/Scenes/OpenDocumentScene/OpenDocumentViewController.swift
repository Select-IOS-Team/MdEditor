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

	let interactor: IOpenDocumentInteractor?
	private let router: IOpenDocumentRouter
	private lazy var tableView = makeTableView()

	// MARK: - Internal properties

	var viewData: [OpenDocumentModel.OpenDocumentViewData.FileViewModel] = []

	// MARK: - Lifecycle

	init(interactor: IOpenDocumentInteractor, router: IOpenDocumentRouter) {
		self.interactor = interactor
		self.router = router
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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.backBarButtonItem = UIBarButtonItem(
			title: "",
			style: UIBarButtonItem.Style.plain,
			target: nil,
			action: nil
		)
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
		let model = viewData[indexPath.row]
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.scrollsToTop = true
		self.router.routeToViewController(menuItem: model.menuItem, root: model.fullName, title: model.name)
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
