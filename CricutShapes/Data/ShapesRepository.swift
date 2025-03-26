//
//  ShapesRepository.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/26/25.
//

import SwiftData

struct ShapesRepository {
    let context: ModelContext
    
    func addShape(path: DrawPath, order: Int) {
        let newItem = Shape(drawPath: path, order: order)
        context.insert(newItem)
    }
    
//    func deleteShape
}

