//
//  FileExplorerWorker.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import Foundation

/// Класс файла.
final class File {

	// MARK: - Internal Properties

	var fileName: String = ""
	var filePath: String = ""
	var fileExtension: String = ""
	var fileSize: UInt64 = 0
	var fileIsDir = false
	var creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		return "\(filePath)/\(fileName)"
	}
}

/// Файл менеджер
protocol IFileExplorerWorker {
	func fillFiles(path: String) -> [File]
	func getFile(url: URL) -> File?
}

/// Класс файл менеджера
class FileExplorerWorker: IFileExplorerWorker {

	// MARK: - Internal Properties

	var files: [File] = []

	// MARK: - Internal Methods

	func fillFiles(path: String) -> [File] {
		files.removeAll()
		let fileManager = FileManager.default
		var documents: [File] = []
		var folders: [File] = []
		guard let urlPath = URL(string: path, relativeTo: Bundle.main.resourceURL) else { return [] }

		do {
			let items = try fileManager.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil)
			items.forEach { item in
				guard let file = getFile(url: item) else { return }
				if file.fileIsDir {
					folders.append(file)
				} else {
					documents.append(file)
				}
			}
		} catch {
		}

		files.append(contentsOf: folders)
		files.append(contentsOf: documents)
		return files
	}

	func getFile(url: URL) -> File? {
		let fileManager = FileManager.default
		do {
			let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
			let file = File()
			file.fileName = url.lastPathComponent
			file.filePath = url.relativePath
			file.fileExtension = url.deletingPathExtension().lastPathComponent
			guard let fileSize = attributes[FileAttributeKey.size] as? UInt64 else { return nil }
			file.fileSize = fileSize
			guard let fileIsDir = attributes[FileAttributeKey.type] as? FileAttributeType else { return nil }
			file.fileIsDir = fileIsDir == FileAttributeType.typeDirectory
			return file
		} catch {
		}
		return nil
	}
}
