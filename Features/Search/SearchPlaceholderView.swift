import SwiftUI
import SwiftData

struct SearchPlaceholderView: View {
    let queryText: String
    @Query private var clients: [Client]
    @Query private var designs: [NailDesignSet]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Search")
                .font(.largeTitle.bold())

            PlaceholderCard(title: "Core Spotlight (Phase 2)", subtitle: "Indexing comes next") {
                Text("Query: \(queryText.isEmpty ? "—" : queryText)")
                    .font(.subheadline)
                Text("Local records available: \(clients.count) clients · \(designs.count) designs")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(24)
    }
}
