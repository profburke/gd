import PackageDescription

let package = Package(
    name: "Gd",
    dependencies: [
		.Package(url: "https://bitbucket.org/bluedino/cgd.git", majorVersion: 1)
        ]
    )
