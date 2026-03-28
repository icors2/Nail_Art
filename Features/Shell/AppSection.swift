import Foundation

enum AppSection: String, CaseIterable, Identifiable, Hashable {
    case dashboard
    case clients
    case designs
    case colors
    case stickers
    case search
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .clients: return "Clients"
        case .designs: return "Designs"
        case .colors: return "Colors"
        case .stickers: return "Stickers"
        case .search: return "Search"
        case .settings: return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .dashboard: return "rectangle.grid.2x2"
        case .clients: return "person.2"
        case .designs: return "square.on.square"
        case .colors: return "paintpalette"
        case .stickers: return "seal"
        case .search: return "magnifyingglass"
        case .settings: return "gearshape"
        }
    }
}
