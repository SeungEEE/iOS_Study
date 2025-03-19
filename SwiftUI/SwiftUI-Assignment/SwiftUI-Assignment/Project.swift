import ProjectDescription

let project = Project(
    name: "SwiftUI-Assignment",
    targets: [
        .target(
            name: "SwiftUI-Assignment",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SwiftUI-Assignment",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["SwiftUI-Assignment/Sources/**"],
            resources: ["SwiftUI-Assignment/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SwiftUI-AssignmentTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SwiftUI-AssignmentTests",
            infoPlist: .default,
            sources: ["SwiftUI-Assignment/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SwiftUI-Assignment")]
        ),
    ]
)
