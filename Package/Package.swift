// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EMBookingAppDependencies",
    platforms: [.iOS(.v16)],

    products: [
        .library(
            name: "EMBookingAppDependencies",
            targets: [
                "EMBookingAppDependencies"
            ]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0")
    ],

    targets: [
        .target(
            name: "EMBookingAppDependencies",

            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher")
            ],

            path: "Sources/Common"
        ),

        .testTarget(
            name: "EMBookingAppDependenciesTests",
            dependencies: [
                "EMBookingAppDependencies"
            ],
            path: "Tests/CommonTests"
        )
    ]
)
