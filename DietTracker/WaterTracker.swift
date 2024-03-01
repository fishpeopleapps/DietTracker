//
//  WaterTracker.swift
//  DietTracker
//
//  Created by Kimberly Brewer on 2/25/24.
//
// TODO: I am wondering if I am getting an error for the gradient because it is going out of bounds
// TODO: "subtract" from water amount

import SwiftUI

struct WaterTracker: View {
    @AppStorage("waterConsumed") private var waterConsumed = 0.0
    @AppStorage("waterRequired") private var waterRequired = 140.0
    @AppStorage("lastDrink") private var lastDrink = Date.now.timeIntervalSinceReferenceDate
    @State private var showingDrinksMenu = false
    var goalProgress: Double {
        waterConsumed / waterRequired
    }
    var statusText: Text {
            return Text("\(Int(waterConsumed))oz / \(Int(waterRequired))oz")
    }
    var body: some View {
        ZStack {
            Background(screen: .water)
            
            VStack(spacing: 0) {
                
                Image(systemName: "drop.fill")
                    .resizable()
                    .font(.title.weight(.ultraLight))
                    .scaledToFit()
                    .foregroundStyle(
                        .linearGradient(stops: [Gradient.Stop(color: .clear, location: 0.0),
                                                Gradient.Stop(color: .clear, location: CGFloat(1 - goalProgress)),
                                                Gradient.Stop(color: .white, location: CGFloat(1 - goalProgress))],
                                        startPoint: .top, endPoint: .bottom)
                    )
                    .overlay(
                        Image(systemName: "drop")
                            .resizable()
                            .font(.title.weight(.ultraLight))
                            .scaledToFit()
                    )
                    .onTapGesture {
                        showingDrinksMenu.toggle()
                    }
                VStack {
                    statusText
                        .font(.largeTitle)
                        .padding(.top)
                        .padding(.bottom, 5)
                    Button {
                        waterConsumed = 0
                    } label: {
                        Text("Reset Water")
                    }
                }
                .padding()
            }
        }
        .foregroundStyle(.white)
        .alert("Add Drink", isPresented: $showingDrinksMenu) {
                ForEach([4, 8, 12, 16, 20, 24], id: \.self) { number in
                    Button("\(number)oz") { add(Double(number))}
            }
            Button("Cancel", role: .cancel) { }
        }
        // Allows us to check to see if a new day has started when the user makes the app active
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.didBecomeActiveNotification),
            perform: checkForReset)
        // Allows us to reset once there's a new day (or a bunch of time has passed)
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.significantTimeChangeNotification),
            perform: checkForReset)
    }
    func add(_ amount: Double) {
        lastDrink = Date.now.timeIntervalSinceReferenceDate
        waterConsumed += amount
    }
    func checkForReset(_ notification: Notification) {
        let lastChecked = Date(timeIntervalSinceReferenceDate: lastDrink)
        if Calendar.current.isDateInToday(lastChecked) == false {
            waterConsumed = 0
        }
    }
}

#Preview {
    WaterTracker()
}
