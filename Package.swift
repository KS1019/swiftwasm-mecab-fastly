// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftwasm-mecab-fastly",
    platforms: [
        .macOS("10.15")
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Compute", url: "https://github.com/AndrewBarba/swift-compute-runtime", branch: "main"),
        .package(url: "https://github.com/KS1019/Mecab-Swift", .branch("KS1019/wasm-support"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "swiftwasm-mecab-fastly",
            dependencies: [
                "Compute",
                "Mecab-Swift",
                .product(name: "IPADic", package: "Mecab-Swift")
            ]),
        .testTarget(
            name: "swiftwasm-mecab-fastlyTests",
            dependencies: ["swiftwasm-mecab-fastly"]),
    ]
)
