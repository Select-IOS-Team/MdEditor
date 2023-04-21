//
//  OpenDocumentWorker.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Воркер подготавливающий вью модель
protocol IOpenDocumentWorker {
	/// Подготавливает и передаёт вью данные о каталогах и файлах.
	/// - Parameter data: Mассив `DirectoryObject`.
	/// - Returns : Массив `DirectoryObjectViewModel`
	func prepareViewModel(data: [DirectoryObject]) -> [OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel]
}

/// Воркер подготавливающий вью модель
final class OpenDocumentWorker: IOpenDocumentWorker {

	// MARK: - IOpenDocumentWorker

	func prepareViewModel(data: [DirectoryObject]) -> [OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel] {
		var response = OpenDocumentModel.OpenDocumentViewData(objectsViewModel: []).objectsViewModel
		data.forEach { item in
			let fileViewModel = OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel(
				title: item.name,
				imageName: item.isFolder ? L10n.OpenDocument.Images.folder : L10n.OpenDocument.Images.file,
				name: item.name,
				fullName: item.path,
				menuItem: item.isFolder ? .folder : .document
			)
			response.append(fileViewModel)
		}
		return response
	}
}
