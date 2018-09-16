// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if !swift(>=4.2)
let versions = [3,4]
#else
let versions = [SwiftVersion.v3, .v4, .v4_2]
#endif

#if swift(>=4.0)

let package = Package(
  name: "outcome",
  products: [
    .library(name: "outcome", targets: ["outcome"]),
  ],
  targets: [
    .target(name: "outcome", dependencies: []),
    .testTarget(name: "outcomeTests", dependencies: ["outcome"]),
  ],
  swiftLanguageVersions: versions
)

#else

let package = Package(name: "outcome")

#endif
