import SwiftUI
import SwiftData

@main
struct NailCanvasApp: App {
    private let modelContainer: ModelContainer = SwiftDataStack.makeContainer()

    var body: some Scene {
        WindowGroup {
            RootSplitView()
                .task {
                    SampleDataSeeder.seedIfNeeded(context: modelContainer.mainContext)
                }
        }
        .modelContainer(modelContainer)
    }
}
