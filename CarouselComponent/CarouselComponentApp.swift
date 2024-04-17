//
//  CarouselComponentApp.swift
//  CarouselComponent
//
//  Created by Rohit Ragmahale on 13/04/24.
//


// https://www.youtube.com/watch?v=DgTPWYM5Hm4
// https://stackoverflow.com/questions/77169478/custom-image-slider-view-in-swiftui
// https://www.appcoda.com/scrollview-paging/#google_vignette
// https://www.youtube.com/watch?v=3zBSgXoSugU


import SwiftUI
let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

@main
struct CarouselComponentApp: App {
    var body: some Scene {
        WindowGroup {
            ZoomContentView()
  
        }
    }
}


