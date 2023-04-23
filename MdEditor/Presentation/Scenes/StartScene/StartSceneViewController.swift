//
//  StartSceneViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import SnapKit
import UIKit

/// Вью контроллер стартовой сцены.
protocol IStartSceneViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: StartSceneModel.ViewData)
}

private enum Constants {
	static let recentFilesCollectionViewHeight: CGFloat = 240
	static let recentFilesCollectionViewCellWidth: CGFloat = 150
	static let recentFilesCollectionViewContentSpacing: CGFloat = 10
	static let recentFilesCollectionViewContentInsets = NSDirectionalEdgeInsets(
		top: 10,
		leading: 10,
		bottom: 10,
		trailing: 10
	)
}

/// Вью контроллер стартовой сцены.
final class StartSceneViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IStartSceneInteractor
	private let router: IStartSceneRouter
	private var viewData: StartSceneModel.ViewData = StartSceneModel.ViewData(recentFileItems: [], menuItems: [])

	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		return scrollView
	}()
	private lazy var containerStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		return stackView
	}()
	private lazy var recentFilesCollectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .collectionViewCompositionalLayout)
		collectionView.registerCell(type: RecentFileCollectionViewCell.self)
		collectionView.dataSource = self
		collectionView.allowsSelection = true
		return collectionView
	}()
	private lazy var menuTableView: UITableView = {
		let tableView = DynamicTableView()
		tableView.registerCell(type: MenuItemTableViewCell.self)
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		return tableView
	}()

	// MARK: - Lifecycle

	init(interactor: IStartSceneInteractor, router: IStartSceneRouter) {
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
		setupLayout()
		configureUI()
		interactor.fetchData()
	}
}

// MARK: - IStartSceneViewController

extension StartSceneViewController: IStartSceneViewController {

	func render(viewData: StartSceneModel.ViewData) {
		self.viewData = viewData
		recentFilesCollectionView.reloadData()
		menuTableView.reloadData()
	}
}

// MARK: - UICollectionViewDataSource

extension StartSceneViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewData.recentFileItems.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeue(
			type: RecentFileCollectionViewCell.self,
			for: indexPath
		) else { return UICollectionViewCell() }

		cell.configure(with: viewData.recentFileItems[indexPath.item])
		cell.enableZoomingPressStateAnimation(tapAction: nil)
		return cell
	}
}

// MARK: - UITableViewDataSource

extension StartSceneViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.menuItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeue(
			type: MenuItemTableViewCell.self,
			for: indexPath
		) else { return UITableViewCell() }

		cell.configure(with: viewData.menuItems[indexPath.row])
		cell.enableZoomingPressStateAnimation { [weak self] in
			self?.handleMenuItemTap(at: indexPath.row)
		}
		return cell
	}
}

// MARK: - Private methods

private extension StartSceneViewController {

	func setupUI() {
		view.addSubview(scrollView)
		scrollView.addSubview(containerStackView)
		containerStackView.addArrangedSubview(recentFilesCollectionView)
		containerStackView.addArrangedSubview(menuTableView)
	}

	func setupLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		containerStackView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.width.equalToSuperview()
		}
		recentFilesCollectionView.snp.makeConstraints {
			$0.height.equalTo(Constants.recentFilesCollectionViewHeight)
		}
	}

	func configureUI() {
		view.backgroundColor = .white
		title = L10n.StartScene.title
	}

	func handleMenuItemTap(at index: Int) {
		router.routeToViewController(menuItem: viewData.menuItems[index].menuType)
	}
}

// MARK: - Extensions

private extension UICollectionViewLayout {

	static var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
		let size = NSCollectionLayoutSize(
			widthDimension: .estimated(Constants.recentFilesCollectionViewCellWidth),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: size)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = Constants.recentFilesCollectionViewContentSpacing
		section.contentInsets = Constants.recentFilesCollectionViewContentInsets

		let configuration = UICollectionViewCompositionalLayoutConfiguration()
		configuration.scrollDirection = .horizontal

		return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
	}
}
