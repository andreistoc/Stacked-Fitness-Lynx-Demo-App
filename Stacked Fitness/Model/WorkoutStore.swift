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
    var duration: Int
    var photoURL: String?
    var image: UIImage?
}

class WorkoutStore: ObservableObject {
    var db = Firestore.firestore()
    @Published var workouts: [Workout] = []
    
    
    init(workouts: [Workout] = []) {
        self.workouts = workouts
    }
    
    func fetch(userID: String) {
        db.collection("workouts")
            .whereField("userID", isEqualTo: userID)
            .order(by: "date", descending: true)
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
                        
                        guard let workoutTimestamp = (documentData["date"] as? Timestamp) else {
                            print("No timestamp")
                            return
                        }
                        
                        guard let duration = documentData["duration"] as? Int else {
                            print("No duration")
                            return
                        }
                        
                        let workout = Workout(id: String(document.documentID), name: workoutName, calories: calories, date: Date(timeIntervalSince1970: TimeInterval(workoutTimestamp.seconds)), duration: Int(duration), photoURL: documentData["photoURL"] as? String)
                        
                        self.workouts.append(workout)
                    }
                }
            }
    }
    
    func createWorkout(workout: Workout, userID: String, photo: UIImage?) {
        let id = db.collection("workouts").addDocument(data: [
            "userID": userID,
            "name": workout.name,
            "calories": workout.calories,
            "date": workout.date,
            "createdAt": Date(),
            "duration": Int(workout.duration),
            "photoURL": NSNull()
        ]).documentID
        
        if let photo = photo {
            uploadPhoto(photo: photo, documentID: id)
        }
    }
    
    private func uploadPhoto(photo: UIImage, documentID: String) {
        guard let data = photo.jpegData(compressionQuality: 1.0) else { return }
        let imageName = UUID().uuidString
        
        let imageReference = Storage.storage().reference().child("images").child(imageName)
        imageReference.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print("ERROR could not upload image \(error.localizedDescription)")
                return
            }
            
            imageReference.downloadURL { (url, error) in
                if let error = error {
                    print("ERROR could not get image url \(error.localizedDescription)")
                    return
                }
                
                guard let url = url else {
                    print("Image URL not valid")
                    return
                }
                
                self.db.collection("workouts").document(documentID).updateData([
                    "photoURL": url.absoluteString
                ]) { (error) in
                    if let error = error {
                        print("ERROR connecting image URL to firestore")
                    }
                }
            }
        }
    }
}
