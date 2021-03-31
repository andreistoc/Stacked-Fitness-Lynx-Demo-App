//
//  ContentView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 26.03.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if session.session != nil {
                WorkoutHistoryView()
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
