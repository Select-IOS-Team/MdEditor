//
//  StringConstants.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 23.04.2023.
//

enum StringConstants {
	static let root = "SampleFiles"
	static let aboutName = ".about"
	static let mdExtension = "md"
	static var aboutAppFilePath: String {
		return "\(root)/\(aboutName)"
	}
}
