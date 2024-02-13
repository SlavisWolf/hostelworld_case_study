

import SwiftUI

struct ErrorView: View {
    
    let message: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundStyle(.red)
            Text(message)
                .font(.title)
            .foregroundStyle(.red)
        }
    }
}

#Preview {
    ErrorView(message: "Test error message")
}
