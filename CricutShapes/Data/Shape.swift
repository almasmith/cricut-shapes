//
//  Item.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Foundation
import SwiftData

enum DrawPath: String {
    case circle
    case square
    case triangle
}

@Model
final class Shape {
    var drawPath: String
    var order: Int

    init(drawPath: DrawPath, order: Int) {
        self.drawPath = drawPath.rawValue
        self.order = order
    }
}
