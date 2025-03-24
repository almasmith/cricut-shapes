//
//  ContentView.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import SwiftUI
import SwiftData

// I've recnetly started moving away from MVVM. Mostly to leverage
// what Apple is providing us to simplify our workflow. However, in
// honesty this has primarily been on my own smaller scale projects
// and I don't have direct experience with how well this might scale.
// At my last job, we were still using MVVM (albeit a modified version)
// extensively.

struct ShapesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Shape.order) private var shapes: [Shape]
    
    @State private var buttonNames: [ShapeButton] = []
    @State private var showButtonAlert: Bool = false

    var body: some View {
        let layout = [
            GridItem(.fixed(100), spacing: 10),
            GridItem(.fixed(100), spacing: 10),
            GridItem(.fixed(100), spacing: 10)
        ]
        
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(shapes) { shape in
                    shape.view
                        .overlay {
                            Text(shape.order.description)
                                .foregroundStyle(.white)
                                .offset(shape.drawPath == DrawPath.triangle.rawValue ? .init(width: 0, height: 12) : .zero)
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Clear All") {
                    clearAll()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CirclesView()
                } label: {
                    Text("Edit Circles")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    ForEach(buttonNames, id: \.name) { buttonName in
                        Button(action: {
                            addShape(path: buttonName.drawPath)
                        }) {
                            Text(buttonName.name)
                        }
                        if buttonName.name != buttonNames.last!.name {
                            Spacer()
                        }
                    }
                }
            }
        }
        
        .task {
            do {
                buttonNames = try await ShapeButton.fetchAll()
            } catch {
                showButtonAlert = true
            }
        }
        .alert(isPresented: $showButtonAlert) {
            .init(title: Text("Error"), message: Text("Could not load button names"))
        }
    }

    private func addShape(path: DrawPath) {
        withAnimation {
            let order = (shapes.last?.order ?? 0) + 1
            let newItem = Shape(drawPath: path, order: order)
            modelContext.insert(newItem)
        }
    }
    
    private func clearAll() {
        deleteShapes(offsets: .init(integersIn: shapes.indices))
    }

    private func deleteShapes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(shapes[index])
            }
        }
    }
}

#Preview {
    NavigationStack{
        ShapesView()
    }
    .environment(\.modelContext, SampleData.container.mainContext)
}
