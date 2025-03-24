//
//  TitleInfoView.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import SwiftUI

// I had created this because my original implementation used a plain list that allowed swipe to delete.
// However, after revisiting the requirements, I noticed that while it said the UI did not have to look
// identical, it did explicityly specify a grid.
struct ShapeInfoView: View {
    var shape: Shape
    
    var body: some View {
        HStack(spacing: 20) {
            shape.view
            VStack(alignment: .leading) {
                TitleInfoView(title: "Draw Path:", info: shape.drawPath)
                TitleInfoView(title: "Order", info: shape.order.description)
            }
        }
    }
    
    private struct TitleInfoView: View {
        var title: String
        var info: String
        
        var body: some View {
            HStack(spacing: 5) {
                Text(title)
                    .foregroundStyle(.primary)
                
                Text(info)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

extension Shape {
    // A view to render for our shapes
    var view: some View {
        HStack {
            switch DrawPath(rawValue: drawPath) {
            case .circle: Circle().fill(Color.red)
            case .square: Rectangle().fill(Color.blue)
            case .triangle: Path { path in
                path.move(to: .init(x: 50, y: 0))
                path.addLine(to: .init(x: 100, y: 100))
                path.addLine(to: .init(x: 0, y: 100))
                path.closeSubpath()
            }.fill(Color.green)
            default:
                EmptyView()
            }
        }
        .frame(width: 100, height: 100)
    }
    
}

#Preview {
    VStack(alignment: .leading) {
        ShapeInfoView(shape: SampleData.shapes[0])
        ShapeInfoView(shape: SampleData.shapes[2])
        ShapeInfoView(shape: SampleData.shapes[4])
    }
    .padding()
}
