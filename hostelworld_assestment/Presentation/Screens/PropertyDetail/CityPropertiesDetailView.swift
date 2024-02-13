


import SwiftUI

struct CityPropertiesDetailView: View {
    
    @Environment(Router.self) private var router
    @Bindable private var viewModel: CityPropertiesDetailViewModel
    
    init(id: String) {
        viewModel = CityPropertiesDetailViewModel(selectedPropertyId: id)
    }
    
    var body: some View {
        VStack {
            if let data = viewModel.viewData {
                content(data)
            } else if viewModel.errorMsg.isNotEmpty {
                ErrorView(message: viewModel.errorMsg)
            } else {
                NetworkLoadingView()
            }
        }
        .navigationTitle("Properties detail")
        .onAppear {
            viewModel.loadView()
        }
        
    }
    
    @ViewBuilder
    private func content(_ data: CityPropertiesDetailViewData) -> some View {
        ScrollView {
            VStack {
                header(data)
                bodyView(data)
                    .padding(.vertical, 21)
            }
        }
        .alert("Check in", isPresented: $viewModel.showCheckInAlert) {
            Button("Ok") {}
        } message: {
            Text("Check in starts at \(data.checkInStarts) and ends at \(data.checkInEnds)")
        }
    }
    
    @ViewBuilder
    private func header(_ data: CityPropertiesDetailViewData) -> some View {

        AsyncDefaultScaleToFitImage(url: data.images.first?.original)
        .overlay(alignment: .bottomLeading) {
            ZStack {
                Text(data.name)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                
            }
            .background(.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20) )
            .padding(.leading, 10)
            .padding(.bottom, 20)
            
        }
    }
    
    @ViewBuilder
    private func bodyView(_ data: CityPropertiesDetailViewData) -> some View {
        HStack {
            VStack(alignment: .leading) {
                propertyTypeTag(text: data.type)
                Text(data.description)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)
                checkInButton()
                    .padding(.top, 10)
                addressCard(data)
                    .padding(.top, 16)
                if data.images.count > 1 {
                    gallery(data)
                }
            }
            .padding(.horizontal, 30)
            Spacer()
        }
    }
    @ViewBuilder
    private func addressCard(_ data: CityPropertiesDetailViewData) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                dataSectionCard(title: "Address:", value: data.address1)
                if data.address2.isNotEmpty {
                    dataSectionCard(title: "Second address:", value: data.address2)
                }
                dataSectionCard(title: "Country:", value: data.country)
                dataSectionCard(title: "City:", value: data.city)
                dataSectionCard(title: "Directions:", value: data.directions, showSeparator: false)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 16)
            Spacer()
        }
        .defaultCardViewStyle()
    }
    
    @ViewBuilder
    private func dataSectionCard(title: String, value: String, showSeparator: Bool = true) -> some View {
        VStack {
            Text(title)
                .font(.headline)
                .underline()
            Text(value)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
            if showSeparator {
                Divider()
                    .frame(height: 1.5)
            }
        }
        .padding(.top, 8)
    }
    
    @ViewBuilder
    private func propertyTypeTag(text: String) -> some View {
        ZStack {
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
        }
        .background(.red)
        .clipShape(Capsule())
    }
    
    @ViewBuilder 
    private func checkInButton() -> some View {
        HStack {
            Spacer()
            Button("Consult check in") {
                viewModel.checkInButtonClicked()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8) )
            Spacer()
        }
    }
    @ViewBuilder
    private func gallery(_ data: CityPropertiesDetailViewData) -> some View {
        
        let columns = Array(repeating: GridItem(.flexible() ), count: 2 )
        
        
        VStack(alignment: .leading) {
            
            Text("Gallery")
                .font(.title)
                .padding(.top, 10)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data.images, id: \.original) { imageUrl in
                    VStack {
                        AsyncDefaultScaleToFitImage(url: imageUrl.large)
                            .onTapGesture {
                                router.navigate(to: .imageEnlarged(url: imageUrl.original) )
                            }
                    }
                }
            }
        }
    }

    
    private struct AsyncDefaultScaleToFitImage: View {
        
        let url: URL?
        
        var body: some View {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image.defaultNoImage
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}


#Preview {
    NavigationStack {
        CityPropertiesDetailView(id: "40919")
            .environment(Router() )
    }
    
}
