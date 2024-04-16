import SwiftUI


struct Item: Identifiable {
    var id: Int
    var title: String
    var color: Color
}

class Store: ObservableObject {
    @Published var items: [Item]
    
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    // dummy data
    init() {
        items = []
        for i in 0...7 {
            let new = Item(id: i, title: "Item \(i)", color: colors[i])
            items.append(new)
        }
    }
}

struct ZStackContentView<Content: View>: View {
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    
    let width = UIScreen.main.bounds.width * 0.8
    
    
     
    var contentCount: Int
    var content: (Int) -> Content
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]
    var body: some View {
        VStack {
            ZoomContentView()
            
            ZStack {
                ForEach(0..<self.contentCount, id: \.self) { index in
                    // article view\
                    self.content(index)
                        .frame(width: width, height: width/1.5)
                    .scaleEffect(1.0 - abs(distance(index)) * 0.3 )
                    .opacity(1.0 - abs(distance(index)) * 0.3 )
                    .offset(x: myXOffset(index), y: 0)
                    .zIndex(1.0 - abs(distance(index)) * 0.1)
                }
            }
            .padding(0)
            .background(Color(.yellow))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        print(value.translation.width)
                        draggingItem = snappedItem + value.translation.width / 100
                        
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(contentCount))
                            snappedItem = draggingItem
                            
                            //print(snappedItem)
                        }
                    }
            )
        }
       
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(contentCount))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(contentCount) * distance(item)
        let value = sin(angle) * 200
        print("Xoffset = \(value)")
        return value
    }
    
}
