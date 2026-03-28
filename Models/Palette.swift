import Foundation
import SwiftData

@Model
final class Palette {
    @Attribute(.unique) var id: UUID
    var name: String
    var hexValues: [String]
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        hexValues: [String] = [],
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.hexValues = hexValues
        self.createdAt = createdAt
    }
}
