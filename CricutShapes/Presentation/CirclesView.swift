//
//  Circles.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import SwiftData
import SwiftUI

struct CirclesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Shape.order) private var shapes: [Shape]
    
    var circles: [Shape] {
        shapes.filter({ $0.drawPath == DrawPath.circle.rawValue })
    }

    var body: some View {
        
        // Using the reader here so that we can take full advantage of the iPad
        // screen real estate.
        GeometryReader { geometry in
            let columns = Int(geometry.size.width / 120)
            let layout = Array(repeating: GridItem(.fixed(100), spacing: 10), count: columns)
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(shapes.filter({ $0.drawPath == DrawPath.circle.rawValue })) { shape in
                        shape.view
                            .overlay {
                                Text(shape.order.description)
                                    .foregroundStyle(.white)
                            }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    Button("Delete All") {
                        deleteAll()
                    }
                    Spacer()
                    Button("Add") {
                        addCircle()
                    }
                    Spacer()
                    Button("Remove") {
                        removeCircle()
                    }
                }
            }
        }
    }
    
    private func deleteAll() {
        for shape in circles {
            modelContext.delete(shape)
        }
    }
    
    private func addCircle() {
        let order = (shapes.last?.order ?? 0) + 1
        let newItem = Shape(drawPath: .circle, order: order)
        modelContext.insert(newItem)
    }
    
    private func removeCircle() {
        if let circle = circles.last {
            modelContext.delete(circle)
        }
    }
}

#Preview {
    NavigationStack {
        CirclesView()
            .modelContainer(SampleData.container)
    }
}
