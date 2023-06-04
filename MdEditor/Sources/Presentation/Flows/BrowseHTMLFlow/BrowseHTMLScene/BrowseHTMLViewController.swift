//
//  BrowseHTMLViewController.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 05.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit
import RegexBuilder
import WebKit

/// Вью контроллер сцены просмотра файла в виде HTML-страницы..
protocol IBrowseHTMLViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: BrowseHTMLModel.ViewData)
}

/// Вью контроллер сцены просмотра файла в виде HTML-страницы..
final class BrowseHTMLViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IBrowseHTMLInteractor
	private var viewData = BrowseHTMLModel.ViewData(text: "", htmlText: "")
	private lazy var webView: WKWebView = {
		let webView = WKWebView()
		webView.navigationDelegate = self
		return webView
	}()

	// MARK: - Lifecycle

	init(interactor: IBrowseHTMLInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = webView
		setupUI()
		setupNavigation()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.fetchData()
	}
}

// MARK: - IBrowseHTMLViewController

extension BrowseHTMLViewController: IBrowseHTMLViewController {

	func render(viewData: BrowseHTMLModel.ViewData) {
		webView.loadHTMLString(viewData.htmlText, baseURL: nil)
		webView.allowsBackForwardNavigationGestures = false
	}
}

// MARK: - WKNavigationDelegate

extension BrowseHTMLViewController: WKNavigationDelegate {}

// MARK: - Private methods

private extension BrowseHTMLViewController {

	private func setupUI() {
		webView = .init()
		webView.navigationDelegate = self
		view = webView
	}

	private func setupNavigation() {
		let barButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "printer.fill"),
			style: .plain,
			target: self,
			action: #selector(showPdfScene)
		)
		navigationItem.setRightBarButton(barButtonItem, animated: true)
	}

	@objc
	private func showPdfScene() {
		interactor.showPdfScene()
	}
}
