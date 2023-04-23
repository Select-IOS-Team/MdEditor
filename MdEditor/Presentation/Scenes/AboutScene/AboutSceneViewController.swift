//
//  AboutSceneViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 20.04.2023.
//

import UIKit
import SnapKit

/// Контроллер сцены с информацией о приложении
protocol IAboutSceneViewController: AnyObject {
	func render(viewData: AboutSceneModel.ViewData)
}

/// Контроллер сцены с информацией о приложении
final class AboutSceneViewController: UIViewController {

	// MARK: - Nested types

	private enum Constants {
		static let aboutLabelNumberOfLines: Int = 0
		static let additionalTextColor = Palette.additionalText
	}

	// MARK: - Private properties

	private let interactor: IAboutSceneInteractor
	private var viewData = AboutSceneModel.ViewData(information: "")
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

	init(interactor: IAboutSceneInteractor) {
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

// MARK: - IAboutSceneViewController

extension AboutSceneViewController: IAboutSceneViewController {

	func render(viewData: AboutSceneModel.ViewData) {
		aboutLabel.text = viewData.information
	}
}

// MARK: - Private methods

private extension AboutSceneViewController {

	func setupUI() {
		view.addSubview(aboutLabel)
	}

	func setupLayout() {
		aboutLabel.snp.makeConstraints { make -> Void in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}
}
