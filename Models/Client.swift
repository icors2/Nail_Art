import Foundation
import SwiftData

@Model
final class Client {
    @Attribute(.unique) var id: UUID
    var name: String
    var phone: String?
    var email: String?
    var notes: String
    var favoriteShapes: [String]
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .nullify, inverse: \Tag.clients)
    var tags: [Tag]

    @Relationship(deleteRule: .nullify, inverse: \NailDesignSet.client)
    var linkedDesigns: [NailDesignSet]

    init(
        id: UUID = UUID(),
        name: String,
        phone: String? = nil,
        email: String? = nil,
        notes: String = "",
        favoriteShapes: [String] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now,
        tags: [Tag] = [],
        linkedDesigns: [NailDesignSet] = []
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.notes = notes
        self.favoriteShapes = favoriteShapes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.linkedDesigns = linkedDesigns
    }
}
