import Foundation
import SwiftData

@MainActor
enum SampleDataSeeder {
    static func seedIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<Client>()
        let existingCount = (try? context.fetchCount(descriptor)) ?? 0

        guard existingCount == 0 else { return }

        let bridalTag = Tag(name: "Bridal")
        let editorialTag = Tag(name: "Editorial")
        let frequentTag = Tag(name: "Frequent")

        let blush = SavedColor(name: "Blush Linen", rgbaHex: "#E7C6C0FF", notes: "Soft bridal neutral", tags: [bridalTag])
        let noir = SavedColor(name: "Runway Noir", rgbaHex: "#1A1A1AFF", notes: "High contrast detail", tags: [editorialTag])
        let chrome = SavedColor(name: "Mirror Silver", rgbaHex: "#C6CCD4FF", notes: "Metallic accent")

        let floralSticker = StickerAsset(name: "Botanical Trace", category: .floral, tags: [bridalTag])
        let lineSticker = StickerAsset(name: "Fine Arc", category: .lineArt, tags: [editorialTag])

        let ava = Client(
            name: "Ava Thompson",
            phone: "+1 (415) 555-0194",
            email: "ava@example.com",
            notes: "Prefers short appointments and soft neutral palettes.",
            favoriteShapes: ["Almond", "Oval"],
            tags: [frequentTag, bridalTag]
        )

        let mia = Client(
            name: "Mia Rodriguez",
            phone: "+1 (415) 555-0112",
            email: "mia@example.com",
            notes: "Requests editorial references from social campaigns.",
            favoriteShapes: ["Coffin", "Stiletto"],
            tags: [editorialTag]
        )

        let bridalDesign = NailDesignSet(
            title: "Ava Spring Bridal Set",
            shapePreset: .almond,
            notes: "Micro pearl line with soft cuticle glow.",
            tags: [bridalTag],
            linkedColors: [blush, chrome],
            linkedStickers: [floralSticker],
            draftState: .approved,
            templateType: .fullSet
        )
        bridalDesign.client = ava

        let campaignDesign = NailDesignSet(
            title: "Mia Campaign Chrome",
            shapePreset: .coffin,
            notes: "Geometric chrome framing for photoshoot lighting.",
            tags: [editorialTag],
            linkedColors: [noir, chrome],
            linkedStickers: [lineSticker],
            draftState: .inReview,
            templateType: .pressOn
        )
        campaignDesign.client = mia

        let snapshot = DesignSnapshot(payload: Data("phase1-snapshot".utf8), note: "Initial concept pass")
        snapshot.design = campaignDesign
        campaignDesign.snapshots = [snapshot]

        let folder = FolderCollection(
            name: "Spring Spotlight",
            type: .seasonalLooks,
            linkedDesignIDs: [bridalDesign.id, campaignDesign.id],
            tags: [bridalTag, editorialTag]
        )

        [bridalTag, editorialTag, frequentTag,
         blush, noir, chrome,
         floralSticker, lineSticker,
         ava, mia,
         bridalDesign, campaignDesign,
         snapshot,
         folder].forEach(context.insert)

        try? context.save()
    }
}
