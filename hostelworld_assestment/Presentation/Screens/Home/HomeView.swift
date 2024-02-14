



import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var router = Router()
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack(path: $router.navPath) {
            VStack {
                if viewModel.errorMsg.isNotEmpty {
                    ErrorView(message: viewModel.errorMsg)
                } else {
                    propertyList()
                }
            }
            .onAppear {
                viewModel.loadView()
            }
            .overlay {
                if viewModel.showLoading {
                    NetworkLoadingView()
                }
            }
            .navigationTitle("Property list")
            .navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .propertiesDetail(let id):
                    CityPropertiesDetailView(id: id)
                case .imageEnlarged(url: let url):
                    EnlargedUrlImage(url: url)
                }
            }
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    private func propertyList() -> some View {
        List {
            ForEach(viewModel.properties, id: \.propertyId) { data in
                
                HomeCellView(data: data)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        router.navigate(to: .propertiesDetail(id: data.propertyId) )
                    }
            }
        }
        .listStyle(PlainListStyle() )
        .scrollContentBackground(.hidden)
    }
}


#Preview {
        HomeView()
}
