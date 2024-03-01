//
//  Component-FillImage.swift
//  DietTracker
//
//  Created by Kimberly Brewer on 3/1/24.
//

import SwiftUI


struct FillImage: View {
    var fillImageName: String
    var emptyImageName: String
    var progress: Double
    var body: some View {
        Image(systemName: fillImageName)
            .resizable()
            .font(.title.weight(.ultraLight))
            .scaledToFit()
            .foregroundStyle(
                .linearGradient(stops: [Gradient.Stop(color: .clear, location: 0.0),
                                        Gradient.Stop(color: .clear, location: CGFloat(1 - progress)),
                                        Gradient.Stop(color: .white, location: CGFloat(1 - progress))],
                                startPoint: .top, endPoint: .bottom)
            )
            .overlay(
                Image(systemName: emptyImageName)
                    .resizable()
                    .font(.title.weight(.ultraLight))
                    .scaledToFit()
            )
    }
}


