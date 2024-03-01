//
//  Components.swift
//  DietTracker
//
//  Created by Kimberly Brewer on 2/29/24.
//

import SwiftUI

enum BackgroundType {
    case water, fruit, greens, task
}

struct Background: View {
    var screen: BackgroundType
    var body: some View {
        switch screen {
        case .water:
            return LinearGradient(colors: [.blue, .cyan, .mint], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
        case .fruit:
            return LinearGradient(colors: [.red, .orange, .yellow], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
        case .greens:
            return LinearGradient(colors: [.teal, .green, .mint], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
        case .task:
            return LinearGradient(colors: [.orange, .pink, .teal], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
        }
        
    }
}
