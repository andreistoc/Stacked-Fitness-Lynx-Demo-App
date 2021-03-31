//
//  WorkoutStore.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI
import Firebase

struct Workout: Identifiable {
    var id: String
    var name: String
    var calories: Int
    var date: Date
    var duration: TimeInterval
    var photoURL: String?
}

class WorkoutStore: ObservableObject {
    var db = Firestore.firestore()
    var workouts: [Workout] = []
    
    
    init(workouts: [Workout] = []) {
        self.workouts = workouts
    }
    
    func fetch(userID: String) {
        db.collection("workouts")
            .whereField("userID", isEqualTo: userID)
            .order(by: "updatedAt", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting docs: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let documentData = document.data()
                        
                        guard let workoutName = documentData["name"] as? String else {
                            print("No workout name")
                            return
                        }
                        
                        guard let calories = documentData["calories"] as? Int else {
                            print("No calories")
                            return
                        }
                        
                        guard let workoutTimestamp = (documentData["date"] as? TimeInterval) else {
                            print("No timestamp")
                            return
                        }
                        
                        guard let duration = documentData["duration"] as? TimeInterval else {
                            print("No duration")
                            return
                        }
                        
                        let workout = Workout(id: String(document.documentID), name: workoutName, calories: calories, date: Date(timeIntervalSince1970: workoutTimestamp), duration: duration, photoURL: documentData["imageURL"] as? String)
                        
                        self.workouts.append(workout)
                    }
                }
            }
    }
    
    func createWorkout(workout: Workout) {
        db.collection("workouts").addDocument(data: [
            "name": workout.name,
            "calories": workout.calories,
            "date": workout.date,
            "duration": Int(workout.duration),
            "photoURL": ""
        ])
    }
}
