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
	/// URL директории Documents.
	var documentDirectoryURL: URL? { get }
	func fillDirectoryObjects(path: String) -> [DirectoryObject]
	func getDirectoryObject(url: URL) -> DirectoryObject?
	func getAboutFile() -> DirectoryObject?
	/// Создает новый файл.
	/// - Parameters:
	///   - directory: Директория, в которой файл будет создан.
	///   - fileName: Имя файла.
	///   - fileExtension: Расширение файла.
	///   - content: Содержимое файла.
	func createFile(in directory: URL, fileName: String, fileExtension: String, withContent content: String)
}

/// Класс файл менеджера
final class FileExplorerManager: IFileExplorerManager {

	var documentDirectoryURL: URL? {
		fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
	}

	// MARK: - Private properties

	private let fileManager: FileManager

	// MARK: - Lifecycle

	init(fileManager: FileManager = FileManager.default) {
		self.fileManager = fileManager
	}

	// MARK: - Internal methods

	func fillDirectoryObjects(path: String) -> [DirectoryObject] {
		var documents: [DirectoryObject] = []
		var folders: [DirectoryObject] = []
		guard let urlPath = URL(string: path, relativeTo: Bundle.main.resourceURL) else { return [] }

		do {
			let items = try fileManager.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil)
			for item in items {
				guard let isHidden = try item.resourceValues(forKeys: [.isHiddenKey]).isHidden else { continue }
				guard !isHidden else { continue }
				guard let file = getDirectoryObject(url: item) else { continue }
				if file.isFolder {
					folders.append(file)
				} else {
					documents.append(file)
				}
			}
		} catch let error as NSError {
			fatalError(error.localizedDescription)
		}
		return folders + documents
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
			withExtension: StringConstants.mdExtension
		) else { return nil }
		return getDirectoryObject(url: url)
	}

	func createFile(in directory: URL, fileName: String, fileExtension: String, withContent content: String) {
		let path = directory.path + "/" + fileName + fileExtension
		let data: Data? = content.data(using: .utf8)
		fileManager.createFile(atPath: path, contents: data, attributes: nil)
	}
}
