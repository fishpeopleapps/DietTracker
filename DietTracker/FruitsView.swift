//
//  FruitsView.swift
//  DietTracker
//
//  Created by Kimberly Brewer on 2/25/24.
//

import SwiftUI

struct FruitsView: View {
    // vars
    @AppStorage("fruitsConsumed") private var fruitsConsumed = 0.0
    @AppStorage("fruitGoal") private var fruitGoal = 3.0
    @AppStorage("lastFruit") private var lastFruit = Date.now.timeIntervalSinceReferenceDate
    @State private var overAchiever = false
    @State private var overAchieverFruits = 3.0
    // what do they call these vars again...
    var goalProgress: Double {
        fruitsConsumed / fruitGoal
    }
    var statusText: Text {
        if overAchiever {
            return Text("\(overAchieverFruits, specifier: "%.2f") / \(fruitGoal, specifier: "%.2f") servings")
        }
        return Text("\(fruitsConsumed, specifier: "%.2f") / \(fruitGoal, specifier: "%.2f") servings")
    }
    // body
    var body: some View {
        ZStack {
            Background(screen: .fruit)
            VStack(spacing: 0) {
                FillImage(fillImageName: "carrot.fill", emptyImageName: "carrot", progress: goalProgress)
                    .onTapGesture {
                        if fruitsConsumed == fruitGoal {
                            overAchiever = true
                            overAchieverFruits += 0.5
                        } else {
                            fruitsConsumed += 0.5
                        }
                    }
                VStack {
                    statusText
                        .font(.largeTitle)
                        .padding(.top)
                        .padding(.bottom, 5)
                    Button {
                        fruitsConsumed = 0
                        overAchieverFruits = 3
                    } label: {
                        Text("Reset Fruits")
                    }
                }
                .padding()
            }
            .padding()
        }
        .foregroundStyle(.white)
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
        lastFruit = Date.now.timeIntervalSinceReferenceDate
        fruitsConsumed += amount
    }
    func checkForReset(_ notification: Notification) {
        let lastChecked = Date(timeIntervalSinceReferenceDate: lastFruit)
        if Calendar.current.isDateInToday(lastChecked) == false {
            fruitsConsumed = 0
        }
    }
}


#Preview {
    FruitsView()
}
