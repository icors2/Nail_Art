import Foundation
import SwiftData

enum SwiftDataStack {
    static func makeContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([
            Client.self,
            NailDesignSet.self,
            SavedColor.self,
            StickerAsset.self,
            Tag.self,
            FolderCollection.self,
            DesignSnapshot.self
        ])

        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Unable to initialize SwiftData container: \(error)")
        }
    }
}
