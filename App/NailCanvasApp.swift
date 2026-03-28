import SwiftUI
import SwiftData

@main
struct NailCanvasApp: App {
    private let modelContainer: ModelContainer = SwiftDataStack.makeContainer()

    var body: some Scene {
        WindowGroup {
            CanvasScreen(viewModel: CanvasViewModel())
                .environment(AutosaveManager(modelContext: modelContainer.mainContext))
        }
        .modelContainer(modelContainer)
    }
}
