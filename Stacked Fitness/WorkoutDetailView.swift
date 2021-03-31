//
//  WorkoutDetailView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 31.03.2021.
//

import SwiftUI
import DateToolsSwift

struct WorkoutDetailView: View {
    var workout: Workout
    
    var body: some View {
        Group {
            VStack {
                Text(workout.name).font(.subheadline)
                    
                // Calories
                    Section(header: Text("Calories")) {
                        Text("\(workout.calories)")
                            .foregroundColor(.blue)
                    }
                    
                // Date
                    Section(header: Text("Date")) {
                        Text("\(workout.date.format(with: "yyyy-MM-dd'T'HH:mm:ss"))")
                            .foregroundColor(.blue)
                    }
                    
                // Photo
                    Section(header: Text("Duration (minutes)")) {
                        Text("\(Int(workout.duration))")
                            .foregroundColor(.blue)
                    }
                    
                // Get and display photo
                }
                Spacer()
            }.padding()
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout(id: "djblyatman", name: "OH MY GOD", calories: 100000, date: Date(), duration: 1200, photoURL: nil))
    }
}
