//
//  NewWorkoutView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 30.03.2021.
//

import SwiftUI

struct NewWorkoutView: View {
    
    // Workout data
    @State var name = ""
    @State var calories: Double = 100
    @State var date = Date()
    @State var duration: Double = 10
    
    // Image data
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var session: SessionStore
    
    @State private var sourceType: Int = 0
    var sourceTypes: [UIImagePickerController.SourceType] = [.photoLibrary, .camera, .savedPhotosAlbum]
    
    var body: some View {
        ZStack {
            Color("background1")
            .ignoresSafeArea()
            VStack {
                Form {
                    Section(header: Text("Workout Name").foregroundColor(.white)) {
                        TextField("Enter a title", text: $name)
                            
                    }
                    

                    Section(header: Text("Calories").foregroundColor(.white)) {
                        Slider(value: $calories, in: 10...1000) {
                            Label("Calories", systemImage: "42.circle")
                        }
                        Text("\(Int(calories))")
                            .foregroundColor(.white)
                    }
                    
                    
                    Section(header: Text("Date").foregroundColor(.white)) {
                        DatePicker(selection: $date, label: { Text("Date") })
                    }
                    
                    Section(header: Text("Duration (minutes)").foregroundColor(.white)) {
                        Slider(value: $duration, in: 1...120) {
                            Label("Duration", systemImage: "42.circle")
                        }
                        Text("\(Int(duration))")
                            .foregroundColor(.white)
                    }
                    
                    // OPTION TO UPLOAD PHOTO
                    Section(header: Text("Upload Photo").foregroundColor(.white)) {
                        HStack{
                            Spacer()
                            Button(action: {
                                self.showingImagePicker = true
                            }) {
                                Text("Get Photo")
                            }
                            Spacer()
                        }
                        Picker(selection: $sourceType, label: Text("Select mode")) {
                            Text("Photo Library").tag(0)
                            Text("Camera").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Section(header: Text("Create Workout").foregroundColor(.white)) {
                        HStack{
                            Spacer()
                            Button(action: createWorkout) {
                                Text("Submit")
                            }
                            Spacer()
                        }
                    }
                }.onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
            }
        }.navigationTitle(Text("New Workout"))
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: UIImagePickerController.SourceType(rawValue: sourceType) ?? .photoLibrary)
        }
    }
    
    func createWorkout() {
        let workout = Workout(id: "", name: name, calories: Int(calories), date: date, duration: Int(duration), photoURL: "")
        workoutStore.createWorkout(workout: workout, userID: self.session.session!.uid, photo: inputImage)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView().environmentObject(SessionStore()).environmentObject(WorkoutStore())
    }
}
