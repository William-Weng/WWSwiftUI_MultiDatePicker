// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSwiftUI_MultiDatePicker",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "WWSwiftUI_MultiDatePicker", targets: ["WWSwiftUI_MultiDatePicker"]),
    ],
    targets: [
        .target(name: "WWSwiftUI_MultiDatePicker", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
