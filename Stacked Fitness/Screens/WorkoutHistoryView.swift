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
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color("background1")
                    .ignoresSafeArea()
                    VStack {
                        ForEach(workoutStore.workouts) { workout in
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutCardView(workout: workout).padding()
                                }
                                
                        }
                        Spacer()
                    }
                    // New workout floating button
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
                .toolbar {
                    NavigationLink(destination:
                        ProfileView()
                    ) {
                        Text("Profile")
                    }
                    
                }
            }.onAppear(perform: fetchWorkouts)
            .accentColor(.white)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView().environmentObject(SessionStore()).environmentObject(WorkoutStore())
    }
}
