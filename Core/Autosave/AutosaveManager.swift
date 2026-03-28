import Foundation
import Observation
import PencilKit
import SwiftData

@Observable
@MainActor
final class AutosaveManager {
    enum SaveState {
        case idle
        case saving
        case saved(Date)
        case failed(String)
    }

    private let modelContext: ModelContext
    private var draftID: UUID?
    private var pendingTask: Task<Void, Never>?

    var saveState: SaveState = .idle

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func scheduleSave(_ drawing: PKDrawing, debounceNanoseconds: UInt64 = 700_000_000) {
        pendingTask?.cancel()
        pendingTask = Task { [weak self] in
            guard let self else { return }

            try? await Task.sleep(nanoseconds: debounceNanoseconds)
            guard !Task.isCancelled else { return }

            await self.persist(drawing)
        }
    }

    private func persist(_ drawing: PKDrawing) {
        saveState = .saving

        do {
            let drawingData = DrawingSerializer.encode(drawing)
            let snapshot: DraftSnapshot

            if let draftID,
               let existing = try modelContext.fetch(FetchDescriptor<DraftSnapshot>(
                predicate: #Predicate { $0.id == draftID }
               )).first {
                existing.drawingData = drawingData
                existing.updatedAt = .now
                snapshot = existing
            } else {
                let newSnapshot = DraftSnapshot(drawingData: drawingData)
                modelContext.insert(newSnapshot)
                draftID = newSnapshot.id
                snapshot = newSnapshot
            }

            try modelContext.save()
            saveState = .saved(snapshot.updatedAt)
        } catch {
            saveState = .failed(error.localizedDescription)
        }
    }

    func loadMostRecentDrawing() -> PKDrawing {
        do {
            var descriptor = FetchDescriptor<DraftSnapshot>(
                sortBy: [SortDescriptor(\DraftSnapshot.updatedAt, order: .reverse)]
            )
            descriptor.fetchLimit = 1

            if let latest = try modelContext.fetch(descriptor).first {
                draftID = latest.id
                return DrawingSerializer.decode(latest.drawingData)
            }
        } catch {
            saveState = .failed(error.localizedDescription)
        }

        return PKDrawing()
    }
}
