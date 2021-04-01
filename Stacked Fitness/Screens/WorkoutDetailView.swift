//
//  WorkoutDetailView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 31.03.2021.
//

import SwiftUI
import DateToolsSwift

struct WorkoutDetailView: View {
    var workout: Workout
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("gradient1"), Color("gradient2")]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea([.bottom])
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .foregroundColor(Color("primary"))
                            .font(.title)
                            .fontWeight(.heavy)
                            .lineLimit(nil)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text(workout.date.format(with: "dd/MM/yyyy HH:mm"))
                            .foregroundColor(Color("secondary"))
                        Text("Calories burned: \(workout.calories)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .padding(.top).padding(.bottom)
                        Text("Duration (minutes): \(Int(workout.duration))")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.top).padding(.bottom)
                    }
                    if let imageURL = workout.photoURL {
                        HStack{
                            Spacer()
                        WorkoutImageView(url: imageURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width-60, height: 200)
                            .cornerRadius(30)
                            .padding()
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout(id: "djblyatman", name: "OH MY GOD", calories: 100000, date: Date(), duration: 1200, photoURL: nil))
    }
}
