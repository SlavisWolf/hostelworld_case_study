
import SwiftUI

struct NetworkLoadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ProgressView()
                    .scaleEffect(2.0)
                    .tint(.yellow)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .scaledToFill()
            .background(.black.opacity(0.4) )
        }
    }
}

#Preview {
    NetworkLoadingView()
}
