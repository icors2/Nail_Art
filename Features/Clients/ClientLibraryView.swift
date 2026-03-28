import SwiftUI
import SwiftData

struct ClientLibraryView: View {
    @Query(sort: \Client.name) private var clients: [Client]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Client Library")
                    .font(.largeTitle.bold())

                ForEach(clients) { client in
                    PlaceholderCard(title: client.name, subtitle: client.email ?? "No email") {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(client.phone ?? "No phone")
                                    .font(.subheadline)
                                Text("Favorite Shapes: \(client.favoriteShapes.joined(separator: ", "))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                if !client.notes.isEmpty {
                                    Text(client.notes)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer()
                            Text("\(client.linkedDesigns.count) designs")
                                .font(.caption.weight(.semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.accentColor.opacity(0.12), in: Capsule())
                        }
                    }
                }
            }
            .padding(24)
        }
    }
}
