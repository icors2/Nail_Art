import Foundation
import SwiftData

@Model
final class DesignSnapshot {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    @Attribute(.externalStorage) var payload: Data
    var note: String

    @Relationship(deleteRule: .nullify, inverse: \NailDesignSet.snapshots)
    var design: NailDesignSet?

    init(
        id: UUID = UUID(),
        createdAt: Date = .now,
        payload: Data = Data(),
        note: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.payload = payload
        self.note = note
    }
}
