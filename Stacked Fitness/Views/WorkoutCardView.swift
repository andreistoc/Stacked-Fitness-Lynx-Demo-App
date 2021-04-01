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
                    
//                    Image("Logo")
//                        .resizable()
//                        .renderingMode(.original)
//                        .frame(width: 30, height: 30)
//                        .padding(.trailing, 20.0)
                }
            }
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

