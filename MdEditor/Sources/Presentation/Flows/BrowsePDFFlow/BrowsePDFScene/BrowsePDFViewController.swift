//
//  BrowsePDFViewController.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 01.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import UIKit
import RegexBuilder
import PDFKit

// Вью контроллер сцены просмотра pdf-файла.
protocol IBrowsePDFViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	/// - Parameter viewData: Передается модель типа BrowsePDFModel.
	func render(viewData: BrowsePDFModel.ViewData)
}

// Вью контроллер сцены просмотра pdf-файла.
final class BrowsePDFViewController: UIViewController {

	// MARK: - Private properties

	private let interactor: IBrowsePDFInteractor
	private var viewData = BrowsePDFModel.ViewData(text: "", pdfData: Data())
	private lazy var pdfView: PDFView = {
		let pdfView = PDFView()
		return pdfView
	}()

	// MARK: - Lifecycle

	init(interactor: IBrowsePDFInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		setupUI()
		setupPrintViewController()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.fetchData()
	}
}

// MARK: IBrowseHTMLViewController

extension BrowsePDFViewController: IBrowsePDFViewController {
	
	/// Отображает данные, соответствующие переданной модели.
	/// - Parameter viewData: Передается модель типа BrowsePDFModel.
	func render(viewData: BrowsePDFModel.ViewData) {
		pdfView.autoScales = true
		pdfView.pageBreakMargins = UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16)
		pdfView.document = PDFDocument(data: viewData.pdfData)
	}
}

// MARK: UI Setup

private extension BrowsePDFViewController {

	private func setupUI() {
		pdfView = .init()
		view = pdfView
		if let navigationBarY = navigationController?.navigationBar.frame.maxY {
			pdfView.frame = CGRect(
				x: 0,
				y: navigationBarY,
				width: view.bounds.width,
				height: view.bounds.height - navigationBarY
			)
		}
	}
}

// MARK: Print Controller Setup

private extension BrowsePDFViewController {
	// swiftlint:disable all
	private func setupPrintViewController() {
		let printController = UIPrintInteractionController.shared
		printController.printingItem = viewData.pdfData
		printController.present(animated: true) { _, completed, error in

			if completed {
				print("Completed")
			} else if let error = error {
				print(error.localizedDescription)
			} else {
				print("Canceled")
			}
		}
	}
	// swiftlint:enable all
}
