import Foundation
import SwiftData

@Model
final class SavedColor {
    @Attribute(.unique) var id: UUID
    var name: String
    var rgbaHex: String
    var notes: String
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \Tag.colors)
    var tags: [Tag]

    @Relationship(deleteRule: .nullify, inverse: \NailDesignSet.linkedColors)
    var designs: [NailDesignSet]

    init(
        id: UUID = UUID(),
        name: String,
        rgbaHex: String,
        notes: String = "",
        createdAt: Date = .now,
        tags: [Tag] = [],
        designs: [NailDesignSet] = []
    ) {
        self.id = id
        self.name = name
        self.rgbaHex = rgbaHex
        self.notes = notes
        self.createdAt = createdAt
        self.tags = tags
        self.designs = designs
    }
}
