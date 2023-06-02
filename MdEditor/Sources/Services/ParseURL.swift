//
//  ParseURL.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 10.05.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Cтруктура url-ссылки.
struct ParseURL {
	let header: String
	let url: String
	let additionalHeader: String

	init(header: String, url: String, additionalHeader: String) {
		self.header = header
		self.url = url
		self.additionalHeader = additionalHeader
	}

	enum ParseError: Error {
		case wrongFormat
	}

	static func parse(rawValue: String, pattern: String) -> Result<ParseURL, ParseError> {
		let range = NSRange(rawValue.startIndex..., in: rawValue)
		let regex = try? NSRegularExpression(pattern: pattern)

		var urlHeader: String?
		var urlLink: String?
		var _: String?

		if let match = regex?.firstMatch(in: rawValue, range: range) {
			if let urlHeaderRange = Range(match.range(withName: "header"), in: rawValue) {
				urlHeader = String(rawValue[urlHeaderRange])
			}
			if let urlLinkRange = Range(match.range(withName: "link"), in: rawValue) {
				urlLink = String(rawValue[urlLinkRange])
			}
		}

		if let urlHeader, let urlLink {
			return .success(ParseURL(header: urlHeader, url: urlLink, additionalHeader: ""))
		} else {
			return .failure(.wrongFormat)
		}
	}
}
