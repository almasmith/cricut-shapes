//
//  ShapeButton.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

struct ShapeButton {
    let name: String
    let drawPath: DrawPath
    
    static func fetchAll() async throws -> [ShapeButton] {
        try await ShapeButtonAPI.shapeButtonNames().map { .fromAPI($0) }
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
