//
//  AppView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI

struct WorkoutHistoryView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var workoutStore = WorkoutStore()
    
    func fetchWorkouts() {
        print("Fetching workouts")
        workoutStore.fetch(userID: self.session.session!.uid)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(workoutStore.workouts) { workout in
                    Text(workout.name)
                }
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: NewWorkoutView(),
                            label: {
                                Image(systemName: "plus.circle.fill")
                            })
                    }
                }
            }.navigationBarTitle("Workout History")
        }.onAppear(perform: fetchWorkouts)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView().environmentObject(SessionStore())
    }
}
