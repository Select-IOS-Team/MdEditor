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
	func render(viewData: OpenDocumentModel.OpenDocumentViewData)
}

/// Вью контроллер сцены выбора файлов и папок.
final class OpenDocumentViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IOpenDocumentInteractor
	private var router: IOpenDocumentRoutingLogic
	private var viewData = OpenDocumentModel.OpenDocumentViewData(title: "", objectsViewModel: [])
	private lazy var tableView = makeTableView()

	// MARK: - Lifecycle

	init(interactor: IOpenDocumentInteractor, router: IOpenDocumentRoutingLogic) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		setupUI()
		setupLayout()
		interactor.fetchDirectoryObjects()
	}
}

// MARK: - UITableViewDataSource

extension OpenDocumentViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.objectsViewModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeue(
			type: FileTableViewCell.self,
			for: indexPath
		) else { return UITableViewCell() }

		let model = viewData.objectsViewModel[indexPath.row]
		cell.configure(with: model)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension OpenDocumentViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = viewData.objectsViewModel[indexPath.row]
		guard let navigationController = self.navigationController else { return }
		let coordinator: IOpenDocumentCoordinator = OpenDocumentCoordinator(
			currentPath: StringConstants.root,
			navigationController: navigationController
		)
		coordinator.mainFlowType = StartSceneModel.ViewData.MenuItemType.open
		coordinator.currentPath = model.fullName
		coordinator.objectType = model.menuItem
		interactor.coordinate(openDocumentCoordinator: coordinator)
		// router.routeToViewController(menuItem: model.menuItem, currentPath: model.fullName)
	}
}

// MARK: - IOpenDocumentViewController

extension OpenDocumentViewController: IOpenDocumentViewController {

	func render(viewData: OpenDocumentModel.OpenDocumentViewData) {
		self.viewData = viewData
		self.title = viewData.title
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

	func configureUI() {
		self.navigationItem.backBarButtonItem = UIBarButtonItem(
			title: "",
			style: UIBarButtonItem.Style.plain,
			target: nil,
			action: nil
		)
	}
}
