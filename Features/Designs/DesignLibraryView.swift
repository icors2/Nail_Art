import SwiftUI
import SwiftData

struct DesignLibraryView: View {
    @Query(sort: \NailDesignSet.updatedAt, order: .reverse) private var designs: [NailDesignSet]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Design Library")
                    .font(.largeTitle.bold())

                ForEach(designs) { design in
                    PlaceholderCard(title: design.title, subtitle: "\(design.templateType.rawValue.capitalized) template") {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(design.notes.isEmpty ? "No notes yet" : design.notes)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("Client: \(design.client?.name ?? "Unassigned")")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("Colors: \(design.linkedColors.count) · Stickers: \(design.linkedStickers.count)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 6) {
                                Text(design.draftState.rawValue.capitalized)
                                    .font(.caption.weight(.semibold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.orange.opacity(0.14), in: Capsule())
                                Text(design.updatedAt, style: .date)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(24)
        }
    }
}
