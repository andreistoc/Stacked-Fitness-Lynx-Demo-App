//
//  Stacked_FitnessApp.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 26.03.2021.
//

import SwiftUI
import Firebase

@main
struct Stacked_FitnessApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore()).environmentObject(WorkoutStore())
        }
    }
}
