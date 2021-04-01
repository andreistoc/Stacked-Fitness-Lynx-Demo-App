//
//  ImageLoader.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 01.04.2021.
//

import Foundation

import SwiftUI
import Firebase

class ImageLoader: ObservableObject {
    @Published var data: Data?

    func loadImage(url: String) {
        let imageRef = Storage.storage().reference(forURL: url)
        imageRef.getData(maxSize: 10240 * 10240) { data, error in
            if let error = error {
                print("ERROR GETTING IMAGE \(error)")
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
