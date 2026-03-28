import SwiftUI
import SwiftData

struct StickerLibraryView: View {
    @Query(sort: \StickerAsset.createdAt, order: .reverse) private var stickers: [StickerAsset]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Sticker Library")
                    .font(.largeTitle.bold())

                ForEach(stickers) { sticker in
                    PlaceholderCard(title: sticker.name, subtitle: sticker.category.rawValue.capitalized) {
                        HStack {
                            Text("Payload: \(sticker.encodedPayload.count) bytes")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("Linked to \(sticker.designs.count) designs")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(24)
        }
    }
}
