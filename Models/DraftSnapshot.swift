import Foundation
import SwiftData

@Model
final class DraftSnapshot {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var updatedAt: Date
    @Attribute(.externalStorage) var drawingData: Data

    init(
        id: UUID = UUID(),
        createdAt: Date = .now,
        updatedAt: Date = .now,
        drawingData: Data = Data()
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.drawingData = drawingData
    }
}
