//
//  ShapeButton.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

// I prefer to isolate my UI from using network-based objects. This creates a little
// more boilerplate, but with current tools, it's not really a problem. So rather than
// the UI interfacing directly with the API, it uses application DTOs or model objects.
// Doing this allows us to change whether or not information comes directly from an API
// call or from local storage without having the UI worry about it.

// Shape button DTO
struct ShapeButton {
    let name: String
    let drawPath: DrawPath
    
    // As application grows, functions like these might move into something like `ShapeRepository`
    // that can encpsulate/hide how data is managed.
    static func fetchAll() async throws -> [ShapeButton] {
        try await ShapeButtonAPI.shapeButtonNamesv2().map { .fromAPI($0) }
    }
}

extension ShapeButton {
    static func fromAPI(_ button: ButtonName) -> ShapeButton {
        guard let drawPath = DrawPath(rawValue: button.drawPath) else {
            preconditionFailure("API contract guarantees values of 'circle', 'square', or 'triangle' for drawPath")
        }
        return .init(
            name: button.name,
            drawPath: drawPath
        )
    }
}
