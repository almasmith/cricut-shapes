//
//  Item.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Foundation
import SwiftData

// I generally like to split my application into presentation and data layers with the data layer generally
// being responsible for persistence and ingestion (getting data from backend). If the complexity of the application
// grows significantly and not all logic is encapsulated on a backend, then I'll also add an application layer
// that handles business/application logic that isn't directly related to data transport/storage.

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
