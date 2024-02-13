

import SwiftUI

struct HomeCellView: View {
    
    let data: HomeCellData
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 14) {
                
                AsyncImage(url: data.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 6) )
                    
                } placeholder: {
                    Image.defaultNoImage
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
                
                VStack(alignment: .leading,spacing: 8) {
                    TextRow(title: "Name:", value: data.propertyName)
                    TextRow(title: "Type:", value: data.propertyType)
                    TextRow(title: "City:", value: data.cityName)
                    if let overall = data.ratingPercentage {
                        TextRow(title: "Percentaje:", value: overall)
                    }
                }
                .padding(.vertical, 8)
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .defaultCardViewStyle()
    }
}

fileprivate struct TextRow: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 12))
                .bold()
            Text(value)
                .font(.system(size: 11))
            
        }
    }
}



#Preview {
    
    Group {
        HomeCellView(data: HomeCellData(propertyId: "1",
                                        propertyName: "Homer simpson",
                                        propertyType: "Number 6",
                                        cityName: "Dublin",
                                        ratingPercentage: "65%",
                                        imageUrl: URL(string: "https://estaticos.elcolombiano.com/binrepository/1004x565/112c0/780d565/none/11101/TAUJ/skynews-mickey-mouse-steamboat-willi_44094042_20240102091440.jpg") )  )
        .padding()
        
        HomeCellView(data: HomeCellData(propertyId: "1",
                                        propertyName: "Homer",
                                        propertyType: "Number 6",
                                        cityName: "Dublin",
                                        ratingPercentage: nil,
                                        imageUrl: nil )  )
        .padding()
    }
    
    
    
}
