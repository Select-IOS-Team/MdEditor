
import ProjectDescription

let description = Dependencies(
	swiftPackageManager: [
		.remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .exact("5.6.0"))
	],
	platforms: [.iOS]
)
