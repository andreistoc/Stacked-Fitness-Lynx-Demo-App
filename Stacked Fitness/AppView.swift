//
//  AppView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var session: SessionStore

    
    var body: some View {
        TabView {
            Text("Tab Content 1").tabItem { Text("New Workout") }.tag(1)
            Text("Tab Content 2").tabItem { Text("Workout History") }.tag(2)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
