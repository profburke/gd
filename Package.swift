import PackageDescription

let package = Package(
    name: "Gd",
    dependencies: [
		.Package(url: "https://github.com/profburke/cgd.git", majorVersion: 1)
        ]
    )
