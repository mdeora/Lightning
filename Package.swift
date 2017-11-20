// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Edge",
    dependencies: [
        .package(url: "https://github.com/skylab-inc/StreamKit.git", from: "0.7.0"),
    ],
    targets: [
        .target(name: "Libc"),
        .target(name: "CHTTPParser"),
        .target(name: "POSIX", dependencies: ["Libc"]),
        .target(name: "TCP", dependencies: ["POSIX", "IOStream", "Libc"]),
        .target(name: "HTTP", dependencies: [ "POSIX", "IOStream", "TCP", "CHTTPParser"]),
        .target(name: "IOStream", dependencies: ["POSIX", "StreamKit"]),
        .target(name: "RunLoop"),
        .target(name: "Edge", dependencies: ["TCP", "IOStream", "RunLoop", "HTTP", "Routing"]),
        .target(name: "Routing", dependencies: ["POSIX", "HTTP"]),
    ]
)
