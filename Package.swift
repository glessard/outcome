// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if !swift(>=4.2)
let versions = [4]
#else
let versions = [SwiftVersion.v4, .v4_2]
#endif

let package = Package(
  name: "Outcome",
  products: [
    .library(name: "Outcome", targets: ["Outcome"]),
  ],
  targets: [
    .target(name: "Outcome", dependencies: []),
    .testTarget(name: "OutcomeTests", dependencies: ["Outcome"]),
  ],
  swiftLanguageVersions: versions
)
