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
	func prepareViewModel(data: [DirectoryObject], title: String) -> OpenDocumentModel.OpenDocumentViewData
}

/// Воркер подготавливающий вью модель
final class OpenDocumentWorker: IOpenDocumentWorker {

	// MARK: - IOpenDocumentWorker

	func prepareViewModel(data: [DirectoryObject], title: String) -> OpenDocumentModel.OpenDocumentViewData {
		var response = OpenDocumentModel.OpenDocumentViewData(title: title, objectsViewModel: [])
		data.forEach { item in
			let fileViewModel = OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel(
				name: item.name,
				image: item.isFolder ? Asset.folder : Asset.document,
				fullName: item.path,
				menuItem: item.isFolder ? .folder : .document
			)
			response.objectsViewModel.append(fileViewModel)
		}
		return response
	}
}
