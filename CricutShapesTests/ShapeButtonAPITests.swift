//
//  ShapeButtonAPITests.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Testing
@testable import CricutShapes

// Not a ton to test right now. I'm not a huge fan of testing Apple's code. For example,
// you won't usually see me writing persistence tests to make sure what I'm writing to
// the DB is what I'm getting out of it. But of course if you had a validation layer that
// sat right above the DB, that would be something worthwhile to unit test. But I don't
// usually have a goal of 100% test coverage.

struct ShapeButtonAPITests {
    
    @Test func testAPI() async throws {
        let shapeButtonNames = try await ShapeButtonAPI.shapeButtonNames()
        let drawPaths = shapeButtonNames.map(\.drawPath)
        #expect(drawPaths.contains("circle"))
        #expect(drawPaths.contains("square"))
        #expect(drawPaths.contains("triangle"))
    }
}
