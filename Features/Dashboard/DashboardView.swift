import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \Client.updatedAt, order: .reverse) private var clients: [Client]
    @Query(sort: \NailDesignSet.updatedAt, order: .reverse) private var designs: [NailDesignSet]
    @Query private var colors: [SavedColor]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Studio Dashboard")
                    .font(.largeTitle.bold())

                HStack(spacing: 14) {
                    statTile(title: "Clients", value: "\(clients.count)", icon: "person.3.fill")
                    statTile(title: "Designs", value: "\(designs.count)", icon: "square.stack.3d.up.fill")
                    statTile(title: "Saved Colors", value: "\(colors.count)", icon: "paintpalette.fill")
                }

                PlaceholderCard(title: "Recent Clients", subtitle: "Last updated records") {
                    ForEach(clients.prefix(4)) { client in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(client.name).font(.body.weight(.medium))
                                Text(client.notes.isEmpty ? "No notes" : client.notes)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Text(client.updatedAt, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                PlaceholderCard(title: "Recent Designs", subtitle: "Open sets currently in workflow") {
                    ForEach(designs.prefix(4)) { design in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(design.title).font(.body.weight(.medium))
                                Text("\(design.shapePreset.rawValue.capitalized) · \(design.draftState.rawValue)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text(design.client?.name ?? "Unassigned")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(24)
        }
    }

    private func statTile(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title.bold())
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
