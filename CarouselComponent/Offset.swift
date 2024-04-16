//
//  Offset.swift
//  CarouselComponent
//
//  Created by Rohit Ragmahale on 15/04/24.
//

import SwiftUI

struct Offset: View {
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    @State private var isDragOn = false
    
    func calculateOffset(index: Int) -> Double {
       // print("draggingItem \(draggingItem)")
        if !isDragOn {
            return -(Double(index))
        } else {
            return draggingItem
        }
        
    }
    
    
    var body: some View {
        
        HStack {
            Text("One!")
                .frame(width: 200)
                .font(.system(size: 50))
                .background(Color(.red))
                .offset(x:calculateOffset(index: 0))
            Text("Two!")
                .frame(width: 200)
                .font(.system(size: 50))
                .background(Color(.red))
                .offset(x:calculateOffset(index: 1))
            Text("Three!")
                .frame(width: 200)
                .font(.system(size: 50))
                .background(Color(.red))
                .offset(x:calculateOffset(index: 2))
            Text("Four!")
                .frame(width: 200)
                .font(.system(size: 50))
                .background(Color(.red))
                .offset(x:calculateOffset(index: 3))
        }
        .gesture(
                DragGesture()
                    .onChanged({ value in
                        isDragOn = true
                        draggingItem = snappedItem + value.translation.width
                       // print(draggingItem)
                    })
                    .onEnded({ value in
                        isDragOn = false
                        draggingItem = snappedItem + value.predictedEndTranslation.width
                        
                        
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(4))
                        snappedItem = abs(draggingItem)
                        print(abs(draggingItem))
                    })
            )
    }
}

#Preview {
    Offset()
}
