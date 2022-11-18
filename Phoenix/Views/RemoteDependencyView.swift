import SwiftUI

struct RemoteDependencyView<DependencyType, VersionType>: View
where DependencyType: Identifiable,
      DependencyType: Equatable,
        VersionType: Identifiable {
    let name: String
    let urlString: String

    let allVersionsTypes: [IdentifiableWithTitle<VersionType>]
    let onSubmitVersionType: (VersionType) -> Void
    let versionPlaceholder: String
    let versionTitle: String
    let versionText: String
    let onSubmitVersionText: (String) -> Void

    let allDependencyTypes: [IdentifiableWithSubtype<DependencyType>]
    let enabledTypes: [DependencyType]
    let onUpdateDependencyType: (DependencyType, Bool) -> Void

    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                    .bold()
                Button(action: onRemove) { Image(systemName: "trash") }
            }
            Text(urlString)

            HStack {
                Menu {
                    ForEach(allVersionsTypes) { versionType in
                        Button(versionType.title) { onSubmitVersionType(versionType.value) }
                    }
                } label: {
                    Text(versionTitle)
                }
                .frame(width: 100)
                TextField(versionPlaceholder,
                          text: .init(get: { versionText},
                                      set: { onSubmitVersionText($0) }))
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            VStack(spacing: 0) {
                ForEach(allDependencyTypes) { dependencyType in
                    HStack {
                        Toggle(isOn: .init(get: { enabledTypes.contains(where: { dependencyType.value == $0 }) },
                                           set: { onUpdateDependencyType(dependencyType.value, $0) })) {
                            Text(dependencyType.title)
                        }
                        if let subtitle = dependencyType.subtitle, let subvalue = dependencyType.subValue {
                            Toggle(isOn: .init(get: { enabledTypes.contains(where: { subvalue == $0 }) },
                                               set: { onUpdateDependencyType(subvalue, $0) })) {
                                Text(subtitle)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

struct RemoteDependencyView_Previews: PreviewProvider {
    enum DependencyTypeMock: Hashable, Identifiable {
        var id: Int { hashValue }

        case contract
        case implementation
        case tests
    }

    enum VersionTypeMock: Hashable, Identifiable {
        var id: Int { hashValue }

        case branch
        case version
    }

    static var previews: some View {
        RemoteDependencyView(name: "Name",
                             urlString: "github.com",
                             allVersionsTypes: [
                                .init(title: "branch", value: VersionTypeMock.branch),
                                .init(title: "from", value: VersionTypeMock.version)
                             ],
                             onSubmitVersionType: { _ in },
                             versionPlaceholder: "1.0.0",
                             versionTitle: "from",
                             versionText: "1.5.0",
                             onSubmitVersionText: { _ in },
                             allDependencyTypes: [
                                .init(title: "First", subtitle: nil, value: DependencyTypeMock.contract, subValue: nil),
                                .init(title: "Second", subtitle: "Tests", value: DependencyTypeMock.implementation, subValue: .tests)
                             ],
                             enabledTypes: [.implementation, .tests],
                             onUpdateDependencyType: { _ , _ in},
                             onRemove: { })
    }
}
