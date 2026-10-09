// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LivenessIdentySDK",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "LivenessIdentySDK", targets: ["LivenessIdentySDKWrapper"])
    ],
    dependencies: [
        // Versão travada (exact) — precisa ser EXATAMENTE a mesma que o Facetec declarar, senão
        // o SPM do app consumidor falha a resolução (determinístico, em vez do comportamento
        // indefinido de hoje). Ver especificação para o time Facetec,
        // vendor-facetec-mobile/plans-urgent/corrigir-colisoes-sdks-ios-vendor-facetec.md.
        .package(url: "https://github.com/getsentry/sentry-cocoa.git", exact: "8.58.4")
    ],
    targets: [
        .target(
            name: "LivenessIdentySDKWrapper",
            dependencies: [
                .target(name: "LivenessIdentySDK"),
                .product(name: "Sentry-Dynamic", package: "sentry-cocoa")
            ],
            path: "Sources/LivenessIdentySDKWrapper"
        ),
        .binaryTarget(name: "LivenessIdentySDK", url: "__URL__", checksum: "__CHECKSUM__")
    ]
)
