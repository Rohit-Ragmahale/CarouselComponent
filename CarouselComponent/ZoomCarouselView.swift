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
    
    @State private var viewWidth: CGFloat = 0.0
    @State private var cardWidth: CGFloat = 0.0
    
    @State private var isDragging = false
    
    func getTop(index: Int) -> CGFloat {
        
        if isDragging {
            let val = (Int(abs(self.displacement)) % 40)
            let val2 = CGFloat(val > 40 ? 40 : val)
            return self.currentIndex == index ? val2 : -val2
        } else {
            return self.currentIndex == index ? 0 : 40
        }
        
    }
    
    
    var body: some View {
        HStack {
            Spacer().frame(minWidth: 50, maxWidth: 50)
            GeometryReader { geometry in
                HStack(spacing: 10) {
                    ForEach(0..<self.contentCount, id: \.self) { index in
                        self.content(index)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .scaleEffect(self.scaleEffect(for: index))
                            .offset(x: displacement * 10, y: getTop(index: index))
                            .onTapGesture {
                                self.currentIndex = index
                            }.onAppear {
                                print("card \(geometry.size.width)")
                            }
                            .animation(.spring())
                    }
                }.onAppear {
                    self.viewWidth = geometry.size.width
                    print(viewWidth)
                }
                .offset(x: -(CGFloat(self.currentIndex) * (geometry.size.width + 10)))
                //.animation(.spring())
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.displacement = value.translation.width/10
                            print(self.displacement)
                            isDragging = true
                            
                        })
                        .onEnded({ value in
                            isDragging = false
                            //print(value.translation.width)
                            self.position = self.displacement
                            self.displacement = 0
                            if value.translation.width < 0 && self.currentIndex < self.contentCount - 1 {
                                self.currentIndex += 1
                            } else if value.translation.width > 0 && self.currentIndex > 0 {
                                self.currentIndex -= 1
                            }
                        })
                )
                .background(Color(.yellow))
            }
            Spacer().frame(minWidth: 50, maxWidth: 50)
        }
        .clipped()
    }

    private func scaleEffect(for index: Int) -> CGFloat {
        let delta = abs(currentIndex - index)
        return delta == 0 ? 1.0 : 1.0
    }
}

struct ZoomContentView: View {
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    private func cardAction(index: Int) {
        print("We clicked on \(index) card action")
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZoomCarouselView(contentCount: 2) { index in
                Card1(color: colors[index], index: index)
            }
            .onAppear {
                print("container \(geometry.size.width)")
            }
            .frame(width: geometry.size.width , height: 200)
        })
        
    }
}


struct Card1: View {
    let color:Color
    let index: Int
    
    private func cardAction(index: Int) {
        print("We clicked on \(index) card action")
    }
    
    var body: some View {
        Image("card-\(index)")
            .resizable()
        
        
//        RoundedRectangle(cornerRadius: 2)
//            .fill(color)
//            .foregroundColor(Color.blue)
//            .overlay(HStack {
//                Text("\(index)").foregroundColor(.white)
//                Button(action: {
//                    cardAction(index: index)
//                }, label: {
//                    Text("Button \(index)")
//                })
//            })
    }
}

struct Card2: View {
    let color:Color
    let index: Int
    
    private func cardAction(index: Int) {
        print("We clicked on \(index) card action")
    }
    
    var body: some View {
        Image("card-\(index)")
            .resizable()
//        RoundedRectangle(cornerRadius: 2)
//            .fill(color)
//            .foregroundColor(Color.red)
//            .overlay(HStack {
//                Text("\(index)").foregroundColor(.white)
//                Button(action: {
//                    cardAction(index: index)
//                }, label: {
//                    Text("Button \(index)")
//                })
//            })
    }
}



struct ZoomContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomContentView()
    }
}
