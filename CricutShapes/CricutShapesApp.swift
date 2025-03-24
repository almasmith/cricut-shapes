//
//  CricutShapesApp.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import SwiftUI
import SwiftData

@main
struct CricutShapesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Shape.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                ShapesView()
            } detail: {
                CirclesView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
