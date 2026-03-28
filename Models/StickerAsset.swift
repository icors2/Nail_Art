import Foundation
import SwiftData

enum StickerCategory: String, Codable, CaseIterable, Identifiable {
    case floral
    case geometric
    case chrome
    case lineArt
    case seasonal

    var id: String { rawValue }
}

@Model
final class StickerAsset {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: StickerCategory
    var encodedPayload: Data
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \Tag.stickers)
    var tags: [Tag]

    @Relationship(deleteRule: .nullify, inverse: \NailDesignSet.linkedStickers)
    var designs: [NailDesignSet]

    init(
        id: UUID = UUID(),
        name: String,
        category: StickerCategory,
        encodedPayload: Data = Data(),
        createdAt: Date = .now,
        tags: [Tag] = [],
        designs: [NailDesignSet] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.encodedPayload = encodedPayload
        self.createdAt = createdAt
        self.tags = tags
        self.designs = designs
    }
}
