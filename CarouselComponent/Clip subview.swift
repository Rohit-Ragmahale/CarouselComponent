//
//  Clip subview.swift
//  CarouselComponent
//
//  Created by Rohit Ragmahale on 17/04/24.
//

import SwiftUI

struct Clip_subview: View {
    var body: some View {
    
            HStack {
                HStack {
                    Text("ok")
                }.frame(width: 400, height: 200)
                    .background(Color(.red))
                    
            }
            .frame(width: 300, height: 300)
            .background(Color(.yellow))
            .clipped()
            
        
        
//        Rectangle()
//            .fill(Color.red)
        
    }
}

#Preview {
    Clip_subview()
}
