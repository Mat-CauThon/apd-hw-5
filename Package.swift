// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "ShoppingArchitecture", platforms: [.macOS(.v13)],
    products: [
        .library(name: "CartDomain", targets: ["CartDomain"]),
        .library(name: "CatalogData", targets: ["CatalogData"]),
        .library(name: "ShoppingApp", targets: ["ShoppingApp"]),
        .executable(name: "ShopDemo", targets: ["ShopDemo"])
    ],
    targets: [
        .target(name: "CartDomain"),
        .target(name: "CatalogData", dependencies: []),
        .target(name: "ShoppingApp", dependencies: ["CartDomain"]),
        .executableTarget(name: "ShopDemo", dependencies: ["ShoppingApp", "CartDomain", "CatalogData"]),
        .testTarget(name: "ArchitectureTests", dependencies: ["CartDomain", "CatalogData", "ShoppingApp"])
    ]
)
