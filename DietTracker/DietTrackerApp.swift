//
//  DietTrackerApp.swift
//  DietTracker
//
//  Created by Kimberly Brewer on 2/25/24.
//

import SwiftUI

@main
struct DietTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("TODO", systemImage: "checklist.unchecked")
                    }
                LeafyGreensView()
                    .tabItem {
                        Label("Leafy Greens", systemImage: "birthday.cake")
                    }
                FruitsView()
                    .tabItem {
                        Label("Fruits", systemImage: "carrot")
                    }
                WaterTracker()
                    .tabItem {
                        Label("Water", systemImage: "drop")
                    }
            }
            
        }
    }
}
