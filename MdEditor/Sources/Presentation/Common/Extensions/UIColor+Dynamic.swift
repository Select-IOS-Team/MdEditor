//
//  UIColor+Dynamic.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import UIKit

extension UIColor {

	static func dynamicColor(
		light: UIColor,
		dark: UIColor,
		highContrastLight: UIColor,
		highContrastDark: UIColor
	) -> UIColor {
		UIColor(dynamicProvider: { traitCollection in
			let isDarkMode = traitCollection.userInterfaceStyle == .dark
			let isHighContrast = traitCollection.accessibilityContrast == .high

			switch (isDarkMode, isHighContrast) {
			case (true, false):
				return dark
			case (true, true):
				return highContrastDark
			case (false, true):
				return light
			case (false, false):
				return highContrastLight
			}
		})
	}

	static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
		UIColor(dynamicProvider: { traitCollection in
			return traitCollection.userInterfaceStyle == .dark ? dark : light
		})
	}
}
