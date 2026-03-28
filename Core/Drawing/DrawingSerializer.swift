import Foundation
import PencilKit

enum DrawingSerializer {
    static func encode(_ drawing: PKDrawing) -> Data {
        drawing.dataRepresentation()
    }

    static func decode(_ data: Data) -> PKDrawing {
        (try? PKDrawing(data: data)) ?? PKDrawing()
    }
}
