//
//  AboutAppSceneViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import UIKit
import SnapKit

/// Вью контроллер сцены с информацией о приложении.
protocol IAboutAppSceneViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: AboutAppSceneModel.ViewData)
}

/// Вью контроллер сцены с информацией о приложении.
final class AboutAppSceneViewController: UIViewController {

	// MARK: - Nested types

	private enum Constants {
		static let aboutLabelNumberOfLines: Int = 0
		static let additionalTextColor = Palette.additionalText
	}

	// MARK: - Private properties

	private let interactor: IAboutAppSceneInteractor
	private var viewData = AboutAppSceneModel.ViewData(information: "")
	private lazy var aboutLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.backgroundColor = Palette.background
		label.textAlignment = .center
		label.textColor = Constants.additionalTextColor
		label.numberOfLines = Constants.aboutLabelNumberOfLines
		return label
	}()

	// MARK: - Lifecycle

	init(interactor: IAboutAppSceneInteractor) {
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

// MARK: - IAboutAppSceneViewController

extension AboutAppSceneViewController: IAboutAppSceneViewController {

	func render(viewData: AboutAppSceneModel.ViewData) {
		aboutLabel.text = viewData.information
	}
}

// MARK: - Private methods

private extension AboutAppSceneViewController {

	func setupUI() {
		view.addSubview(aboutLabel)
	}

	func setupLayout() {
		aboutLabel.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}
