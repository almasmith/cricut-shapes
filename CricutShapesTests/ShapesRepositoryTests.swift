//
//  ShapesRepositoryTests.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/26/25.
//

import Testing
@testable import CricutShapes
import SwiftData
import Foundation

struct ShapesRespositoryTests {
    
    @MainActor
    @Test func testAddCircle() async throws {
        let context = SampleData.container.mainContext
        let repo = ShapesRepository(context: context)
        let predicate = #Predicate<Shape> { _ in return true }
        repo.addShape(path: .circle, order: 0)
        let shapes: [Shape] = try context.fetch(.init(predicate: predicate))
        #expect(shapes.contains(where: { $0.drawPath == DrawPath.circle.rawValue}))
    }
    
    @MainActor
    @Test func testAddSquare() async throws {
        let context = SampleData.container.mainContext
        let repo = ShapesRepository(context: context)
        let predicate = #Predicate<Shape> { _ in return true }
        repo.addShape(path: .square, order: 0)
        let shapes: [Shape] = try context.fetch(.init(predicate: predicate))
        #expect(shapes.contains(where: { $0.drawPath == DrawPath.circle.rawValue}))
    }
    
    @MainActor
    @Test func testAddTriangle() async throws {
        let context = SampleData.container.mainContext
        let repo = ShapesRepository(context: context)
        let predicate = #Predicate<Shape> { _ in return true }
        repo.addShape(path: .triangle, order: 0)
        let shapes: [Shape] = try context.fetch(.init(predicate: predicate))
        #expect(shapes.contains(where: { $0.drawPath == DrawPath.circle.rawValue}))
    }
    
    @MainActor
    @Test func testAddBox() async throws {
        let context = SampleData.container.mainContext
        let repo = ShapesRepository(context: context)
        let predicate = #Predicate<Shape> { _ in return true }
        repo.addShape(path: .box, order: 0)
        let shapes: [Shape] = try context.fetch(.init(predicate: predicate))
        #expect(shapes.contains(where: { $0.drawPath == DrawPath.circle.rawValue}))
    }
}
