

import SwiftUI

struct EnlargedUrlImage: View {
    
    @GestureState private var zoom = 1.0
    let url: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(zoom)
                    .gesture(
                        MagnifyGesture()
                            .updating($zoom) { value, gestureState, transaction in
                                gestureState = value.magnification
                            }
                    )
            } placeholder: {
                Image.defaultNoImage
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    EnlargedUrlImage(url: URL(string: "https://i.blogs.es/1cf49d/stewieg_1/650_1200.jpg")! )
}
