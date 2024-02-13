

import SwiftUI

//MARK: Modifiers
struct CardViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20) )
            .shadow(color: Color.gray.opacity(0.35), radius: 10, x: 0, y: 2)
    }
}

//MARK: Calls
extension View {
    func defaultCardViewStyle() -> some View {
        self.modifier(CardViewModifier() )
    }
}
