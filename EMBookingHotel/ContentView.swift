import SwiftUI

struct ContentView: View {
    var body: some View {
        ImageCarouselView(model: .Examples.model)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
