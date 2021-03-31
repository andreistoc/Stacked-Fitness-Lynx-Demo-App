//
//  NewWorkoutView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI

struct NewWorkoutView: View {
    @State var name = ""
    @State var calories: Double = 100
    @State var date = Date()
    @State var duration: Double = 10
    
    @ObservedObject var workoutStore = WorkoutStore()
    
    var body: some View {
        Group {
            VStack {
                Text("New Workout").font(.subheadline)
                Form {
                    Section(header: Text("Workout Name")) {
                        TextField("Enter a title", text: $name)
                    }
                    

                    Section(header: Text("Calories")) {
                        Slider(value: $calories, in: 10...1000) {
                            Label("Calories", systemImage: "42.circle")
                        }
                        Text("\(Int(calories))")
                            .foregroundColor(.blue)
                    }
                    
                    
                    Section(header: Text("Date")) {
                        DatePicker(selection: $date, label: { Text("Date") })
                    }
                    
                    Section(header: Text("Duration (minutes)")) {
                        Slider(value: $duration, in: 1...120) {
                            Label("Duration", systemImage: "42.circle")
                        }
                        Text("\(Int(duration))")
                            .foregroundColor(.blue)
                    }
                    
                    // OPTION TO UPLOAD PHOTO
                    Section(header: Text("Upload Photo")) {
                        HStack{
                            Spacer()
                            Button(action: getPhoto) {
                                Text("Get Photo")
                            }
                            Spacer()
                        }
                    }
                    
                    Section(header: Text("Create Workout")) {
                        HStack{
                            Spacer()
                            Button(action: createWorkout) {
                                Text("Submit")
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
            }.padding()
        }
    }
    
    func createWorkout() {
        let workout = Workout(id: "", name: name, calories: Int(calories), date: date, duration: duration, photoURL: "")
        workoutStore.createWorkout(workout: workout)
    }
    
    func getPhoto() {
        
    }
}

struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView().environmentObject(SessionStore())
    }
}
