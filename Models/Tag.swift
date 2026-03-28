import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdAt: Date

    @Relationship(deleteRule: .nullify)
    var clients: [Client]

    @Relationship(deleteRule: .nullify)
    var designs: [NailDesignSet]

    @Relationship(deleteRule: .nullify)
    var colors: [SavedColor]

    @Relationship(deleteRule: .nullify)
    var stickers: [StickerAsset]

    @Relationship(deleteRule: .nullify)
    var folders: [FolderCollection]

    init(
        id: UUID = UUID(),
        name: String,
        createdAt: Date = .now,
        clients: [Client] = [],
        designs: [NailDesignSet] = [],
        colors: [SavedColor] = [],
        stickers: [StickerAsset] = [],
        folders: [FolderCollection] = []
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.clients = clients
        self.designs = designs
        self.colors = colors
        self.stickers = stickers
        self.folders = folders
    }
}
