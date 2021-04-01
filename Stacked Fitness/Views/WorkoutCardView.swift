//
//  WorkoutCardView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 01.04.2021.
//

import SwiftUI

struct WorkoutCardView: View {
    var workout: Workout
    
    var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(workout.date.format(with: "dd/MM/yyyy HH:mm"))
                            .foregroundColor(.white)
                    }
                    .frame(width: 150, alignment: .leading)
                    .padding(20)
                    Spacer()
                    
                    if let imageURL = workout.photoURL {
                        WorkoutImageView(url: imageURL)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
            .background(Color("card"))
            .cornerRadius(10)
            .shadow(radius: 10)
    }

}

