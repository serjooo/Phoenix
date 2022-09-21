import AppVersionProvider
import AppVersionProviderContract
import ComponentDetailsProvider
import ComponentDetailsProviderContract
import DemoAppFeature
import DemoAppGenerator
import DemoAppGeneratorContract
import DocumentCoder
import DocumentCoderContract
import Factory
import Foundation
import PackageGenerator
import PackageGeneratorContract
import PackageStringProvider
import PackageStringProviderContract
import PBXProjectSyncer
import PBXProjectSyncerContract
import ProjectGenerator
import ProjectGeneratorContract
import RelativeURLProvider
import RelativeURLProviderContract
import SwiftPackage

extension Container {
    static let currentAppVersionStringProvider = Factory { Bundle.main as CurrentAppVersionStringProviderProtocol }
    static let appVersionStringParser = Factory { AppVersionStringParser() as AppVersionStringParserProtocol }
    static let currentAppVersionProvider = Factory {
        CurrentAppVersionProvider(
            appVersionStringProvider: Container.currentAppVersionStringProvider(),
            appVersionStringParser: Container.appVersionStringParser()
        ) as CurrentAppVersionProviderProtocol
    }

    static let phoenixDocumentFileWrappersDecoder = Factory {
        PhoenixDocumentFileWrappersDecoder(
            appVersionStringParser: Container.appVersionStringParser()
        ) as PhoenixDocumentFileWrappersDecoderProtocol
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
            packageGenerator: Container.packageGenerator(),
            packageNameProvider: PackageNameProvider(),
            packagePathProvider: Container.packagePathProvider(),
            relativeURLProvider: Container.relativeURLProvider(),
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
            componentPackagesProvider: Container.componentPackagesProvider(),
            packageGenerator: Container.packageGenerator()
        ) as ProjectGeneratorProtocol
    }
    
    static let demoAppNameProvider = Factory {
        DemoAppNameProvider() as DemoAppNameProviderProtocol
    }
    
    static let appVersionUpdateProvider = Factory {
        AppVersionUpdateProvider() as AppVersionUpdateProviderProtocol
    }
    
    static let filesURLDataStore = Factory {
        FilesURLDataStore(
            dictionaryCache: UserDefaults.standard
        ) as FilesURLDataStoreProtocol
    }
    
    static let relativeURLProvider = Factory {
        RelativeURLProvider() as RelativeURLProviderProtocol
    }
}

extension Bundle: CurrentAppVersionStringProviderProtocol {
    public func currentAppVersionString() -> String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
