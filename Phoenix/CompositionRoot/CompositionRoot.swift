import ComponentDetailsProvider
import ComponentDetailsProviderContract
import DemoAppFeature
import DemoAppGenerator
import DemoAppGeneratorContract
import DocumentCoder
import DocumentCoderContract
import Factory
import Foundation
import GenerateFeatureDataStore
import GenerateFeatureDataStoreContract
import PackageGenerator
import PackageGeneratorContract
import PackageStringProvider
import PackageStringProviderContract
import PBXProjectSyncer
import PBXProjectSyncerContract
import ProjectGenerator
import ProjectGeneratorContract
import ProjectValidator
import ProjectValidatorContract
import RelativeURLProvider
import RelativeURLProviderContract
import SwiftPackage

extension Container {
    static let phoenixDocumentFileWrappersDecoder = Factory {
        PhoenixDocumentFileWrappersDecoder() as PhoenixDocumentFileWrappersDecoderProtocol
    }

    static let phoenixDocumentFileWrapperEncoder = Factory {
        PhoenixDocumentFileWrapperEncoder(
            currentAppVersionStringProvider: Container.currentAppVersionStringProvider()
        ) as PhoenixDocumentFileWrapperEncoderProtocol
    }
    
    static let packageGenerator = Factory {
        PackageGenerator(
            fileManager: .default,
            packageStringProvider: Container.packageStringProvider()
        ) as PackageGeneratorProtocol
    }
    
    static let demoAppGenerator = Factory {
        DemoAppGenerator(
            fileManager: FileManager.default
        ) as DemoAppGeneratorProtocol
    }
    
    static let familyFolderNameProvider = Factory {
        FamilyFolderNameProvider() as FamilyFolderNameProviderProtocol
    }
    
    static let packageNameProvider = Factory {
        PackageNameProvider() as PackageNameProviderProtocol
    }
    
    static let packageStringProvider = Factory {
        PackageStringProvider() as PackageStringProviderProtocol
    }
    
    static let packageFolderNameProvider = Factory {
        PackageFolderNameProvider(
            defaultFolderNameProvider: Container.familyFolderNameProvider()
        ) as PackageFolderNameProviderProtocol
    }
    
    static let packagePathProvider = Factory {
        PackagePathProvider(
            packageFolderNameProvider: Container.packageFolderNameProvider(),
            packageNameProvider: Container.packageNameProvider()
        ) as PackagePathProviderProtocol
    }
    
    static let componentPackageProvider = Factory {
        ComponentPackageProvider(
            packageFolderNameProvider: Container.packageFolderNameProvider(),
            packageNameProvider: Container.packageNameProvider(),
            packagePathProvider: Container.packagePathProvider()
        ) as ComponentPackageProviderProtocol
    }
    
    static let componentPackagesProvider = Factory {
        ComponentPackagesProvider(
            componentPackageProvider: Container.componentPackageProvider()
        ) as ComponentPackagesProviderProtocol
    }
    
    static let documentPackagesProvider = Factory {
        DocumentPackagesProvider(
            componentPackagesProvider: componentPackagesProvider()
        ) as DocumentPackagesProviderProtocol
    }
    
    static let pbxProjSyncer = Factory {
        PBXProjectSyncer(
            packageFolderNameProvider: Container.packageFolderNameProvider(),
            packageNameProvider: Container.packageNameProvider(),
            packagePathProvider: Container.packagePathProvider(),
            projectWriter: Container.pbxProjectWriter(),
            relativeURLProvider: Container.relativeURLProvider()
        ) as PBXProjectSyncerProtocol
    }
    
    static let pbxProjectWriter = Factory {
        PBXProjectWriter() as PBXProjectWriterProtocol
    }
    
    static let projectGenerator = Factory {
        ProjectGenerator(
            documentPackagesProvider: documentPackagesProvider(),
            packageGenerator: Container.packageGenerator()
        ) as ProjectGeneratorProtocol
    }
    
    static let demoAppNameProvider = Factory {
        DemoAppNameProvider() as DemoAppNameProviderProtocol
    }
    
    static let relativeURLProvider = Factory {
        RelativeURLProvider() as RelativeURLProviderProtocol
    }
    
    static let generateFeatureDataStore = Factory(scope: .singleton) {
        GenerateFeatureDataStore(
            dictionaryCache: UserDefaults.standard
        ) as GenerateFeatureDataStoreProtocol
    }
    
    static let projectValidator = Factory(scope: .singleton) {
        ProjectValidator(
            decoder: phoenixDocumentFileWrappersDecoder()
        ) as ProjectValidatorProtocol
    }
}
