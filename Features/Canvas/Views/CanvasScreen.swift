import SwiftUI
import SwiftData

struct CanvasScreen: View {
    @State private var viewModel: CanvasViewModel
    @Environment(AutosaveManager.self) private var autosaveManager

    init(viewModel: CanvasViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                toolPanel
                    .frame(width: 220)
                    .background(Color(uiColor: .secondarySystemBackground))

                ZStack(alignment: .topTrailing) {
                    LinearGradient(
                        colors: [.white, .white.opacity(0.95)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    PencilKitCanvasView(
                        drawing: $viewModel.drawing,
                        toolState: viewModel.toolState
                    ) { _ in
                        viewModel.drawingDidChange(using: autosaveManager)
                    }
                    .padding(24)

                    NCSaveStatusBadge(state: autosaveManager.saveState)
                        .padding(20)
                }
            }
            .navigationTitle("NailCanvas")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            viewModel.restoreIfPossible(using: autosaveManager)
        }
    }

    private var toolPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tools")
                .font(.headline)

            Button("Pen") {
                viewModel.setEraserEnabled(false)
            }
            .buttonStyle(.borderedProminent)

            Button("Eraser") {
                viewModel.setEraserEnabled(true)
            }
            .buttonStyle(.bordered)

            VStack(alignment: .leading, spacing: 8) {
                Text("Line Width")
                    .font(.subheadline.weight(.medium))
                Slider(value: Binding(
                    get: { viewModel.toolState.lineWidth },
                    set: { viewModel.setLineWidth($0) }
                ), in: 1...18)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Quick Colors")
                    .font(.subheadline.weight(.medium))

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 8) {
                    ForEach(ColorPreset.allCases) { preset in
                        Button {
                            viewModel.setColor(preset)
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(preset.color)
                                .frame(height: 36)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    let container = SwiftDataStack.makeContainer(inMemory: true)
    CanvasScreen(viewModel: CanvasViewModel())
        .environment(AutosaveManager(modelContext: container.mainContext))
}
