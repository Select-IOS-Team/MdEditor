//
//  FileExplorerSceneViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit
import SnapKit

/// Вью контроллер сцены файлового менеджера.
protocol IFileExplorerSceneViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: FileExplorerSceneModel.ViewData)
}

/// Вью контроллер сцены файлового менеджера.
final class FileExplorerSceneViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IFileExplorerSceneInteractor
	private var viewData = FileExplorerSceneModel.ViewData(title: "", objectViewModels: [])
	private lazy var tableView = makeTableView()

	// MARK: - Lifecycle

	init(interactor: IFileExplorerSceneInteractor) {
		self.interactor = interactor
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

extension FileExplorerSceneViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.objectViewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeue(
			type: FileTableViewCell.self,
			for: indexPath
		) else { return UITableViewCell() }

		let model = viewData.objectViewModels[indexPath.row]
		cell.configure(with: model)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension FileExplorerSceneViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor.didChooseDirectoryObject(at: indexPath.row)
	}
}

// MARK: - IFileExplorerSceneViewController

extension FileExplorerSceneViewController: IFileExplorerSceneViewController {

	func render(viewData: FileExplorerSceneModel.ViewData) {
		self.viewData = viewData
		self.title = viewData.title
		tableView.reloadData()
	}
}

// MARK: - Private methods

private extension FileExplorerSceneViewController {

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
