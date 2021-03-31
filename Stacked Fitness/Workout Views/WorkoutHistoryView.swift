//
//  AppView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI

struct WorkoutHistoryView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var workoutStore: WorkoutStore
    
    func fetchWorkouts() {
        print("Fetching workouts")
        workoutStore.fetch(userID: self.session.session!.uid)
    }
    
    var body: some View {
            ZStack {
                ForEach(workoutStore.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        Text(workout.name)
                    }
                }
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button( action: {
                            NewWorkoutView()
                        }, label: {
                            Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 70, height: 70)
                                .foregroundColor(Color.white)
                                //.padding(.bottom, 7)
                        })
                        .background(Color.red)
                        .cornerRadius(35)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
            }.onAppear(perform: fetchWorkouts)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView().environmentObject(SessionStore())
    }
}
