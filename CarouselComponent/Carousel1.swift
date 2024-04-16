//
//  Carousel1.swift
//  CarouselComponent
//
//  Created by Rohit Ragmahale on 13/04/24.
//

import SwiftUI

struct ZoomCarouselView<Content: View>: View {
    var contentCount: Int
    var content: (Int) -> Content

    @State private var currentIndex = 0
    @State private var displacement: Double = 0
    @State private var position: Double = 0

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<self.contentCount, id: \.self) { index in
                    self.content(index)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .scaleEffect(self.scaleEffect(for: index))
                        .offset(x: displacement * 10)
                        .onTapGesture {
                            self.currentIndex = index
                        }
                }
            }
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .animation(.spring())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.displacement =  self.position + value.translation.width/10
                    })
                    .onEnded({ value in
                        self.displacement = 0
                        if value.translation.width < 0 && self.currentIndex < self.contentCount - 1 {
                            self.currentIndex += 1
                        } else if value.translation.width > 0 && self.currentIndex > 0 {
                            self.currentIndex -= 1
                        }
                    })
            )
        }
    }

    private func scaleEffect(for index: Int) -> CGFloat {
        let delta = abs(currentIndex - index)
        return delta == 0 ? 1.0 : 0.85
    }
}

struct ZoomContentView: View {
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    private func cardAction(index: Int) {
        print("We clicked on \(index) card action")
    }
    
    var body: some View {
        ZoomCarouselView(contentCount: 5) { index in
            RoundedRectangle(cornerRadius: 2)
                .fill(colors[index])
                .foregroundColor(Color.blue)
                .overlay(HStack {
                    Text("\(index)").foregroundColor(.white)
                    Button(action: {
                        cardAction(index: index)
                    }, label: {
                        Text("Button \(index)")
                    })
                })
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
    }
}

struct ZoomContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomContentView()
    }
}
