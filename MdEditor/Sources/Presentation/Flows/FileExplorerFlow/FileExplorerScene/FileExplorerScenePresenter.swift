//
//  FileExplorerScenePresenter.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import Foundation

/// Презентер сцены файлового менеджера.
protocol IFileExplorerScenePresenter {
	/// Подготавливает и передаёт вью данные о содержимом открытой директории.
	/// - Parameter response: Модель `StartSceneModel.Response`.
	func presentData(response: FileExplorerSceneModel.Response)
}

/// Презентер сцены файлового менеджера.
final class FileExplorerScenePresenter: IFileExplorerScenePresenter {

	// MARK: - Internal properties

	weak var viewController: IFileExplorerSceneViewController?

	// MARK: - IFileExplorerScenePresenter

	func presentData(response: FileExplorerSceneModel.Response) {
		let title = response.directoryPath.split(separator: "/").last ?? ""
		let viewData = FileExplorerSceneModel.ViewData(
			title: String(title),
			objectViewModels: mapDirectoryObjects(response.directoryObjects)
		)
		viewController?.render(viewData: viewData)
	}

	// MARK: - Private methods

	private func mapDirectoryObjects(
		_ objects: [DirectoryObject]
	) -> [FileExplorerSceneModel.ViewData.DirectoryObjectViewModel] {
		objects.map { object in
			FileExplorerSceneModel.ViewData.DirectoryObjectViewModel(
				name: object.name,
				image: object.isFolder ? Asset.folder : Asset.file
			)
		}
	}
}
