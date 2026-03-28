import Foundation
import SwiftData

enum FolderCollectionType: String, Codable, CaseIterable, Identifiable {
    case clientBoards
    case seasonalLooks
    case socialDrafts

    var id: String { rawValue }
}

@Model
final class FolderCollection {
    @Attribute(.unique) var id: UUID
    var name: String
    var type: FolderCollectionType
    var linkedDesignIDs: [UUID]

    @Relationship(deleteRule: .nullify, inverse: \Tag.folders)
    var tags: [Tag]

    init(
        id: UUID = UUID(),
        name: String,
        type: FolderCollectionType,
        linkedDesignIDs: [UUID] = [],
        tags: [Tag] = []
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.linkedDesignIDs = linkedDesignIDs
        self.tags = tags
    }
}
