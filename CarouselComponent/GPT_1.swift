import SwiftUI

struct GPTCarouselView<Content: View>: View {
    var contentCount: Int
    var content: (Int) -> Content
    
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<self.contentCount, id: \.self) { index in
                    self.content(index)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .scaleEffect(self.scaleEffect(for: index))
                        .animation(.spring())
                }
            }
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let offset = value.translation.width
                        let newIndex = self.calculateNewIndex(with: offset, and: geometry.size.width)
                        self.currentIndex = min(max(0, newIndex), self.contentCount - 1)
                    })
            )
        }
    }
    
    private func scaleEffect(for index: Int) -> CGFloat {
        let distance = abs(index - currentIndex)
        return 1.0 - CGFloat(distance) * 0.1
    }
    
    private func calculateNewIndex(with offset: CGFloat, and width: CGFloat) -> Int {
        let delta = Int(offset / width)
        return currentIndex - delta
    }
}

struct GOTContentView: View {
    var body: some View {
        GPTCarouselView(contentCount: 5) { index in
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.blue)
                .overlay(Text("\(index)").foregroundColor(.white))
        }
        .frame(width: 300, height: 200)
    }
}

struct GOTContentView_Previews: PreviewProvider {
    static var previews: some View {
        GOTContentView()
    }
}
