// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chores",
    defaultLocalization: "en",
    platforms: [
        .iOS("16.4")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Chores",
            targets: ["Chores"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../FamilyMembers"),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "0.7.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Chores",
            dependencies: [
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                .product(name: "FamilyMembers", package: "FamilyMembers")
            ]),
        .testTarget(
            name: "ChoresTests",
            dependencies: ["Chores"]),
    ]
)
