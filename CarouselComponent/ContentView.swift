import SwiftUI

import SwiftUI

struct CarouselView<Content: View>: View {
    var contentCount: Int
    var content: (Int) -> Content
    
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<self.contentCount, id: \.self) { index in
                    self.content(index)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .animation(.spring())
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        if value.translation.width < 0 && self.currentIndex < self.contentCount - 1 {
                            self.currentIndex += 1
                        } else if value.translation.width > 0 && self.currentIndex > 0 {
                            self.currentIndex -= 1
                        }
                    })
            )
        }
    }
    
    

}

struct HStackContentView: View {
    var body: some View {
        CarouselView(contentCount: 5) { index in
            Rectangle()
                .foregroundColor(Color.random())
                .overlay(Text("\(index)").foregroundColor(.white))
        }
        .frame(width: 300, height: 200)
    }
}

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct HStackContentView_Previews: PreviewProvider {
    static var previews: some View {
        HStackContentView()
    }
}
