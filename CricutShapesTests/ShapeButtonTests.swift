//
//  ShapeButtonTests.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Testing
@testable import CricutShapes

struct ShapeButtonTests {
    
    @Test func testTransform() async throws {
        let shapeButtons = try await ShapeButton.fetchAll()
        let drawPaths = shapeButtons.map(\.drawPath)
        #expect(drawPaths.contains(.circle))
        #expect(drawPaths.contains(.square))
        #expect(drawPaths.contains(.triangle))
        #expect(drawPaths.contains(.box))
    }
}
