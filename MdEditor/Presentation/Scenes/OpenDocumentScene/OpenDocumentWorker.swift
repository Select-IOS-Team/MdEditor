//
//  OpenDocumentWorker.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Воркер подготавливающий вью модель
protocol IOpenDocumentWorker {
	func prepareViewModel(data: [File]) -> [OpenDocumentModel.OpenDocumentViewData.FileViewModel]
}

/// Класс воркера
class OpenDocumentWorker: IOpenDocumentWorker {

	// MARK: - Internal Methods

	func prepareViewModel(data: [File]) -> [OpenDocumentModel.OpenDocumentViewData.FileViewModel] {
		var response = OpenDocumentModel.OpenDocumentViewData(filesViewModel: []).filesViewModel
		data.forEach { item in
			let fileViewModel = OpenDocumentModel.OpenDocumentViewData.FileViewModel(
				fileTitle: item.fileName,
				fileImageName: item.fileIsDir ? L10n.OpenDocument.Images.folder : L10n.OpenDocument.Images.file,
				name: item.fileName,
				fullName: item.filePath,
				menuItem: item.fileIsDir ? .folder : .document
			)
			response.append(fileViewModel)
		}
		return response
	}
}
