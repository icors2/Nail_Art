import Foundation
import Observation
import PencilKit
import SwiftUI

@Observable
@MainActor
final class CanvasViewModel {
    var drawing: PKDrawing = PKDrawing()
    let toolState = DrawingToolState()

    func restoreIfPossible(using autosaveManager: AutosaveManager) {
        drawing = autosaveManager.loadMostRecentDrawing()
    }

    func drawingDidChange(using autosaveManager: AutosaveManager) {
        autosaveManager.scheduleSave(drawing)
    }

    func setColor(_ colorHex: ColorPreset) {
        toolState.isEraserSelected = false
        toolState.color = colorHex.color
    }

    func setEraserEnabled(_ enabled: Bool) {
        toolState.isEraserSelected = enabled
    }

    func setLineWidth(_ width: CGFloat) {
        toolState.lineWidth = width
    }
}

enum ColorPreset: String, CaseIterable, Identifiable {
    case black
    case red
    case pink
    case nude
    case white

    var id: String { rawValue }

    var color: SwiftUI.Color {
        switch self {
        case .black: return .black
        case .red: return .red
        case .pink: return .pink
        case .nude: return SwiftUI.Color(red: 0.83, green: 0.70, blue: 0.64)
        case .white: return .white
        }
    }
}
