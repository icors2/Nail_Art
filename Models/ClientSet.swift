import Foundation
import SwiftData

@Model
final class ClientSet {
    @Attribute(.unique) var id: UUID
    var clientName: String
    var title: String
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        clientName: String,
        title: String,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.clientName = clientName
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
