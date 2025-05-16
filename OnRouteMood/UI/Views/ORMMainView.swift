//
//  ORMMainView.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import SwiftUI

struct ORMMainView: View {
    
    @StateObject var viewModel: ORMMainViewModel
    
    @State var selectedBus: DomainTrips? = nil
    
    @State private var isShowingForm = false
    
    @State private var showBugList = false
    
    var body: some View {
        VStack {
            HStack {
                Text("OnRouteMood")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                formButtonView
            }
            .padding(.horizontal)
            
            HStack {
                if let bus = selectedBus {
                    VStack {
                        Text("Selected Bus:")
                        Text("\(bus.origin.address) to \(bus.destination.address)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            ORMMapView(selectedBus: $selectedBus)
                .padding()
            
            listTripView
        }
        .padding()
        .background(Color.primaryORM)
        .navigationTitle("OnRouteMood")
        .onAppear {
            viewModel.getTrips()
            viewModel.loadReports()
        }
        .sheet(isPresented: $isShowingForm) {
            sheetView
        }
    }
}

private extension ORMMainView {
    
    var formButtonView: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                isShowingForm = true
            }) {
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 16))
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            
            if savedFormsCount > 0 {
                Text("\(savedFormsCount)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 4, y: -8)
            }
        }
    }
    
    var listTripView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(viewModel.sortedTrips, id: \.id) { trip in
                Button {
                    selectedBus = trip
                } label: {
                    ORMTripCard(
                        trip: trip,
                        isSelected: trip.id == selectedBus?.id
                    )
                }
            }
            
            if viewModel.beError {
                Text("BE ERROR")
                Button {
                    viewModel.getTrips()
                } label: {
                    Text("Retry")
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            ZStack {
                if showBugList {
                    ORMSubmittedFormsView(
                        viewModel: viewModel,
                        showBugList: $showBugList
                    )
                    .transition(
                        .opacity.combined(
                            with: .move(
                                edge: .leading
                            )
                        )
                    )
                } else {
                    ORMFormView(
                        isShowingForm: $isShowingForm,
                        showBugList: $showBugList,
                        viewModel: viewModel
                    )
                    .transition(
                        .opacity.combined(
                            with: .move(
                                edge: .leading
                            )
                        )
                    )
                }
            }
            .animation(.bouncy, value: showBugList)
        }
    }
}

private extension ORMMainView {
    
    var savedFormsCount: Int {
        return viewModel.completedForms.count
    }
}

#Preview {
    ORMMainView(viewModel: ORMMainViewModel(ormInteractor: .init(networkManager: Network())))
}
