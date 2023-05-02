//
//  Palette.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 19.04.2023.
//

import UIKit

/// Палитра цветов.
enum Palette {
	static let main = UIColor.dynamicColor(light: FlatColor.Green.mountainMeadow, dark: FlatColor.Green.persianGreen)
	static let background = UIColor.dynamicColor(light: FlatColor.Gray.whiteSmoke, dark: FlatColor.Gray.nightSky)
	static let accentWarning = UIColor.dynamicColor(light: FlatColor.Red.youngPig, dark: FlatColor.Red.oldRose)

	static let additionalText = UIColor.dynamicColor(light: FlatColor.Gray.spyder, dark: FlatColor.Gray.iron)
}

private enum FlatColor {

	enum Green {
		static let fern = UIColor(hex: 0x6ABB72)
		static let mountainMeadow = UIColor(hex: 0x3ABB9D)
		static let chateauGreen = UIColor(hex: 0x4DA664)
		static let persianGreen = UIColor(hex: 0x2CA786)
	}

	enum Blue {
		static let pictonBlue = UIColor(hex: 0x5CADCF)
		static let mariner = UIColor(hex: 0x3585C5)
		static let curiousBlue = UIColor(hex: 0x4590B6)
		static let denim = UIColor(hex: 0x2F6CAD)
		static let chambray = UIColor(hex: 0x485675)
		static let blueWhale = UIColor(hex: 0x29334D)
	}

	enum Violet {
		static let wisteria = UIColor(hex: 0x9069B5)
		static let blueGem = UIColor(hex: 0x533D7F)
	}

	enum Yellow {
		static let energy = UIColor(hex: 0xF2D46F)
		static let turbo = UIColor(hex: 0xF7C23E)
	}

	enum Orange {
		static let neonCarrot = UIColor(hex: 0xF79E3D)
		static let sun = UIColor(hex: 0xEE7841)
	}

	enum Red {
		static let terraCotta = UIColor(hex: 0xE66B5B)
		static let valencia = UIColor(hex: 0xCC4846)
		static let cinnabar = UIColor(hex: 0xDC5047)
		static let wellRead = UIColor(hex: 0xB33234)
		static let youngPig = UIColor(hex: 0xFFD1D1)
		static let oldRose = UIColor(hex: 0x610000)
	}

	enum Gray {
		static let almondFrost = UIColor(hex: 0xA28F85)
		static let whiteSmoke = UIColor(hex: 0xEFEFEF)
		static let iron = UIColor(hex: 0xD1D5D8)
		static let ironGray = UIColor(hex: 0x75706B)
		static let nightSky = UIColor(hex: 0x101010)
		static let spyder = UIColor(hex: 0x505050)
	}
}
