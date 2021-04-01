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
    
    @State var showWorkoutDetail = false
    
    func fetchWorkouts() {
        print("Fetching workouts")
        workoutStore.fetch(userID: self.session.session!.uid)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ForEach(workoutStore.workouts) { workout in
                        Button(action: {self.showWorkoutDetail.toggle()}) {
                        WorkoutCardView(workout: workout).padding()
                            .sheet(isPresented: $showWorkoutDetail) {
                                WorkoutDetailView(workout: workout)
                            }
                        }
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink( destination: NewWorkoutView()) {
                            Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 70, height: 70)
                                .foregroundColor(Color.white)
                        }.background(Color.red)
                        .cornerRadius(35)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
            }.navigationTitle(Text("Workout History"))
        }.onAppear(perform: fetchWorkouts)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView().environmentObject(SessionStore())
    }
}
