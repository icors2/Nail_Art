import SwiftUI
import PencilKit

@Observable
final class DrawingToolState {
    var color: Color = .black
    var lineWidth: CGFloat = 6
    var isEraserSelected: Bool = false

    var inkTool: PKTool {
        if isEraserSelected {
            return PKEraserTool(.vector)
        }

        return PKInkingTool(.pen, color: UIColor(color), width: lineWidth)
    }
}
