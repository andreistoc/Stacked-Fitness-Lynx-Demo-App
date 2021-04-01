//
//  WorkoutImageView.swift
//  Stacked Fitness
//
//  Created by Andrei Istoc on 01.04.2021.
//

import Foundation
import SwiftUI

struct WorkoutImageView: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader()
        imageLoader.loadImage(url: url)
    }

    var body: some View {
        Image(uiImage:
            imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
            .resizable()
            .renderingMode(.original)
    }
}
