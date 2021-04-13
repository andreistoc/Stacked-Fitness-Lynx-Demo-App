//
//  ProfileView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 12.04.2021.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            Color("background1")
            .ignoresSafeArea()
        }
            .navigationTitle(Text("Profile"))
            .toolbar {
                Button("Sign Out") {
                    session.signOut()
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
