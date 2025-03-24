//
//  SampleData.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import SwiftData

struct SampleData {
    @MainActor
    static let container: ModelContainer = {
        do {
            let container = try ModelContainer(for: Shape.self, configurations: .init(isStoredInMemoryOnly: true))
            for shape in shapes {
                container.mainContext.insert(shape)
            }
            return container
        } catch {
            fatalError("Falied to create sample model container: \(error)")
        }
    }()
    
    static let shapes: [Shape] = [
        .init(drawPath: .circle, order: 0),
        .init(drawPath: .circle, order: 1),
        .init(drawPath: .square, order: 2),
        .init(drawPath: .circle, order: 3),
        .init(drawPath: .triangle, order: 4),
        .init(drawPath: .square, order: 5),
        .init(drawPath: .circle, order: 6),
        .init(drawPath: .triangle, order: 7),
        .init(drawPath: .triangle, order: 8),
        .init(drawPath: .square, order: 9),
        .init(drawPath: .triangle, order: 10),
        .init(drawPath: .circle, order: 11),
        .init(drawPath: .square, order: 12)
    ]
}

