//
//  FileExplorerWorker.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import Foundation

/// Структура объекта в каталоге (файл или папка).
struct DirectoryObject {

	// MARK: - Internal Properties

	var name = ""
	var path = ""
	var objectExtension = ""
	var size: UInt64 = 0
	var isFolder = false
	let creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		return "\(path)/\(name)"
	}

	func getFileText(fullPath: String) -> String {
		var text = ""
		do {
			text = try String(contentsOfFile: fullPath, encoding: String.Encoding.utf8)
		} catch {
		}

		return text
	}
}

/// Файл менеджер
protocol IFileExplorerManager {
	func fillDirectoryObjects(path: String) -> [DirectoryObject]
	func getDirectoryObject(url: URL) -> DirectoryObject?
	func getAboutFile() -> DirectoryObject?
}

/// Класс файл менеджера
final class FileExplorerManager: IFileExplorerManager {

	// MARK: - Private Properties

	private let fileManager: FileManager

	// MARK: - Lifecycle

	init(fileManager: FileManager = FileManager.default) {
		self.fileManager = fileManager
	}

	// MARK: - Internal Methods

	func fillDirectoryObjects(path: String) -> [DirectoryObject] {
		var objects: [DirectoryObject] = []
		let fileManager = FileManager.default
		var documents: [DirectoryObject] = []
		var folders: [DirectoryObject] = []
		guard let urlPath = URL(string: path, relativeTo: Bundle.main.resourceURL) else { return [] }

		do {
			let items = try fileManager.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil)
			items.forEach { item in
				guard let file = getDirectoryObject(url: item) else { return }
				if file.isFolder {
					folders.append(file)
				} else {
					documents.append(file)
				}
			}
		} catch let error as NSError {
			fatalError(error.localizedDescription)
		}

		objects.append(contentsOf: folders)
		objects.append(contentsOf: documents)
		return objects
	}

	func getDirectoryObject(url: URL) -> DirectoryObject? {
		let fileManager = FileManager.default
		do {
			let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
			var file = DirectoryObject()
			file.name = url.lastPathComponent
			file.path = url.relativePath
			file.objectExtension = url.deletingPathExtension().lastPathComponent
			guard let fileSize = attributes[FileAttributeKey.size] as? UInt64 else { return nil }
			file.size = fileSize
			guard let fileIsDir = attributes[FileAttributeKey.type] as? FileAttributeType else { return nil }
			file.isFolder = fileIsDir == FileAttributeType.typeDirectory
			return file
		} catch let error as NSError {
			fatalError(error.localizedDescription)
		}
	}

	func getAboutFile() -> DirectoryObject? {
		guard let url = Bundle.main.url(
			forResource: StringConstants.aboutPath,
			withExtension: StringConstants.aboutExtension
		) else { return nil }
			return getDirectoryObject(url: url)
		}
}
