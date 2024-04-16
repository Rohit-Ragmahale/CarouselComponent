//
//  CarouselComponentApp.swift
//  CarouselComponent
//
//  Created by Rohit Ragmahale on 13/04/24.
//

import SwiftUI
let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

@main
struct CarouselComponentApp: App {
    var body: some Scene {
        WindowGroup {
            
                ZStackContentView(contentCount: 5) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(colors[index])
                        Text("Page-\(index)")
                            .padding()
                    }
                }
                
                
                
            
        }
    }
}
