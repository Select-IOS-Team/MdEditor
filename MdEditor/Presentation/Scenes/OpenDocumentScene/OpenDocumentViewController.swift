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
	var currentPath: String { get set }
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: [OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel])
}

/// Вью контроллер сцены выбора файлов и папок.
final class OpenDocumentViewController: UIViewController {

	// MARK: - Private properties

	let interactor: IOpenDocumentInteractor
	var router: (IOpenDocumentRoutingLogic & IOpenDocumentDataPassing)
	private lazy var tableView = makeTableView()

	// MARK: - Internal properties

	var currentPath = "SampleFiles"
	var viewData: [OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel] = []

	// MARK: - Lifecycle

	init(interactor: IOpenDocumentInteractor, router: (IOpenDocumentRoutingLogic & IOpenDocumentDataPassing)) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.backBarButtonItem = UIBarButtonItem(
			title: "",
			style: UIBarButtonItem.Style.plain,
			target: nil,
			action: nil
		)
		setupUI()
		setupLayout()
		interactor.fetchDirectoryObjects(currentPath: currentPath)
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
		router.dataStore = OpenDocumentRoutingDTO(title: model.title, currentPath: model.fullName)
		router.routeToViewController(menuItem: model.menuItem)
	}
}

// MARK: - IOpenDocumentViewController

extension OpenDocumentViewController: IOpenDocumentViewController {
	func render(viewData: [OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel]) {
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
	}

	func setupLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}
