import Foundation
import SwiftData

enum ShapePreset: String, Codable, CaseIterable, Identifiable {
    case almond
    case square
    case stiletto
    case coffin
    case oval

    var id: String { rawValue }
}

enum DesignDraftState: String, Codable, CaseIterable, Identifiable {
    case draft
    case inReview
    case approved

    var id: String { rawValue }
}

enum NailTemplateType: String, Codable, CaseIterable, Identifiable {
    case fullSet
    case pressOn
    case accentOnly

    var id: String { rawValue }
}

@Model
final class NailDesignSet {
    @Attribute(.unique) var id: UUID
    var title: String
    var createdAt: Date
    var updatedAt: Date
    var shapePreset: ShapePreset
    var notes: String
    var previewImageReference: String?
    var draftState: DesignDraftState
    var templateType: NailTemplateType

    @Relationship(deleteRule: .nullify, inverse: \Client.linkedDesigns)
    var client: Client?

    @Relationship(deleteRule: .nullify, inverse: \Tag.designs)
    var tags: [Tag]

    @Relationship(deleteRule: .nullify, inverse: \SavedColor.designs)
    var linkedColors: [SavedColor]

    @Relationship(deleteRule: .nullify, inverse: \StickerAsset.designs)
    var linkedStickers: [StickerAsset]

    @Relationship(deleteRule: .cascade, inverse: \DesignSnapshot.design)
    var snapshots: [DesignSnapshot]

    init(
        id: UUID = UUID(),
        title: String,
        createdAt: Date = .now,
        updatedAt: Date = .now,
        shapePreset: ShapePreset = .almond,
        notes: String = "",
        previewImageReference: String? = nil,
        tags: [Tag] = [],
        linkedColors: [SavedColor] = [],
        linkedStickers: [StickerAsset] = [],
        draftState: DesignDraftState = .draft,
        templateType: NailTemplateType = .fullSet,
        snapshots: [DesignSnapshot] = []
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.shapePreset = shapePreset
        self.notes = notes
        self.previewImageReference = previewImageReference
        self.tags = tags
        self.linkedColors = linkedColors
        self.linkedStickers = linkedStickers
        self.draftState = draftState
        self.templateType = templateType
        self.snapshots = snapshots
    }
}
