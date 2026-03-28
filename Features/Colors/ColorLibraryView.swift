import SwiftUI
import SwiftData

struct ColorLibraryView: View {
    @Query(sort: \SavedColor.createdAt, order: .reverse) private var colors: [SavedColor]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Color Library")
                    .font(.largeTitle.bold())

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 220), spacing: 14)], spacing: 14) {
                    ForEach(colors) { color in
                        PlaceholderCard(title: color.name, subtitle: color.rgbaHex) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: color.rgbaHex))
                                .frame(height: 72)
                            Text(color.notes.isEmpty ? "No notes" : color.notes)
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

private extension Color {
    init(hex: String) {
        let sanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&int)

        let r, g, b, a: UInt64
        switch sanitized.count {
        case 8:
            r = (int & 0xFF00_0000) >> 24
            g = (int & 0x00FF_0000) >> 16
            b = (int & 0x0000_FF00) >> 8
            a = int & 0x0000_00FF
        case 6:
            r = (int & 0xFF00_00) >> 16
            g = (int & 0x00FF_00) >> 8
            b = int & 0x0000_FF
            a = 255
        default:
            r = 198; g = 204; b = 212; a = 255
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
