import ProjectDescription

let swiftLintScriptBody = "SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
let swiftLintScript = TargetScript.post(script: swiftLintScriptBody, name: "SwiftLint", basedOnDependencyAnalysis: false)

let target = Target(
	name: "MdEditor",
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: "com.evgeniMeleshin.MdEditor",
	deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
	infoPlist: "MdEditor/SupportingFiles/Info.plist",
	sources: ["MdEditor/Sources/**"],
	resources: ["MdEditor/Resources/**", .folderReference(path: "SampleFiles")],
	scripts: [swiftLintScript],
	dependencies: [
		.external(name: "SnapKit")
	]
)

let testTarget = Target(
	name: "MdEditorTests",
	platform: .iOS,
	product: .unitTests,
	bundleId: "com.evgeniMeleshin.MdEditorTests",
	deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
	sources: ["MdEditorTests/Sources/**"],
	dependencies: [
		.target(name: "MdEditor")
	]
)

let baseSettings = SettingsDictionary()
	.currentProjectVersion("1")
	.marketingVersion("1")
	.codeSignIdentityAppleDevelopment()

let project = Project(
	name: "MdEditor",
	organizationName: "Evgeni Meleshin (Personal Team)",
	settings: Settings.settings(base: baseSettings),
	targets: [target, testTarget],
	schemes: [
		Scheme(
			name: "MdEditor",
			shared: true,
			buildAction: .buildAction(targets: ["MdEditor"]),
			testAction: .targets(["MdEditorTests"]),
			runAction: .runAction(executable: "MdEditor")
		),
		Scheme(
			name: "MdEditorTests",
			shared: true,
			buildAction: .buildAction(targets: ["MdEditorTests"]),
			testAction: .targets(["MdEditorTests"]),
			runAction: .runAction(executable: "MdEditorTests")
		)
	]
)
