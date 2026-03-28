import SwiftUI

struct NCSaveStatusBadge: View {
    let state: AutosaveManager.SaveState

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.caption.weight(.semibold))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
    }

    private var label: String {
        switch state {
        case .idle:
            return "Idle"
        case .saving:
            return "Saving…"
        case .saved(let date):
            return "Saved \(date.formatted(date: .omitted, time: .shortened))"
        case .failed:
            return "Save Failed"
        }
    }

    private var indicatorColor: Color {
        switch state {
        case .idle:
            return .gray
        case .saving:
            return .orange
        case .saved:
            return .green
        case .failed:
            return .red
        }
    }
}
