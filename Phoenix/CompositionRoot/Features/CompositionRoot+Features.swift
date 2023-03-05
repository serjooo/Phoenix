import DemoAppFeature
import Factory

extension Container {
    // DemoAppFeature
    static let demoAppFeatureView = ParameterFactory(Container.shared) { (data: DemoAppFeatureInput) in
        DemoAppFeatureView(
            data: data,
            dependency: .init(
                demoAppGenerator: Container.demoAppGenerator(),
                demoAppNameProvider: Container.demoAppNameProvider(),
                packageFolderNameProvider: Container.packageFolderNameProvider(),
                packageNameProvider: Container.packageNameProvider(),
                pbxProjectSyncer: Container.pbxProjSyncer()
            )
        )
    }
}
