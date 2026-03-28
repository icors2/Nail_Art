import SwiftUI

struct RootSplitView: View {
    @State private var selectedSection: AppSection? = .dashboard
    @State private var sidebarSearchText = ""

    var body: some View {
        NavigationSplitView {
            sidebar
                .navigationSplitViewColumnWidth(min: 260, ideal: 300, max: 340)
                .background(.ultraThinMaterial)
        } detail: {
            detailView
                .background(Color(uiColor: .systemGroupedBackground))
        }
        .navigationSplitViewStyle(.balanced)
    }

    private var sidebar: some View {
        List(selection: $selectedSection) {
            Section {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search clients, designs, colors…", text: $sidebarSearchText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(10)
                .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
                .listRowInsets(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                .listRowSeparator(.hidden)
            }

            Section("Workspace") {
                ForEach(AppSection.allCases) { section in
                    Label(section.title, systemImage: section.systemImage)
                        .tag(section)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("NailCanvas")
    }

    @ViewBuilder
    private var detailView: some View {
        switch selectedSection ?? .dashboard {
        case .dashboard:
            DashboardView()
        case .clients:
            ClientLibraryView()
        case .designs:
            DesignLibraryView()
        case .colors:
            ColorLibraryView()
        case .stickers:
            StickerLibraryView()
        case .search:
            SearchPlaceholderView(queryText: sidebarSearchText)
        case .settings:
            SettingsView()
        }
    }
}

#Preview {
    RootSplitView()
        .modelContainer(SwiftDataStack.makeContainer(inMemory: true))
}
