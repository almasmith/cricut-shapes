//
//  ShapeButtonAPITests.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Testing
@testable import CricutShapes

struct ShapeButtonAPITests {
    
    @Test func testAPI() async throws {
        let shapeButtonNames = try await ShapeButtonAPI.shapeButtonNames()
        let drawPaths = shapeButtonNames.map(\.drawPath)
        #expect(drawPaths.contains("circle"))
        #expect(drawPaths.contains("square"))
        #expect(drawPaths.contains("triangle"))
    }
}
