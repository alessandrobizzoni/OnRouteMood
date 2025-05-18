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
    
    @State var selectedStop: DomainStopPoint?
    
    @State var isShowingStopInfo: Bool = false
    
    var body: some View {
        VStack {
            
            headerView
            
            ZStack {
                ORMMapView(
                    selectedBus: $selectedBus,
                    selectedStop: $selectedStop,
                    isShowingStopInfo: $isShowingStopInfo
                )
                .padding()
                
                stopInfo
            }
            
            listTripView
        }
        .padding()
        .background(Color.primaryORM)
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $isShowingForm) {
            sheetView
        }
    }
}

private extension ORMMainView {
    
    var headerView: some View {
        Group {
            HStack {
                Text("OnRouteMood")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                formButtonView
            }
            .padding(.horizontal)
            
            HStack {
                if let busDestination = selectedBus?.destination.address {
                    VStack(alignment: .leading) {
                        Text("Selected Bus:")
                        Text("Road to \(busDestination)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
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
                    .padding(.all, 5)
                }
            }
            
            if viewModel.beError {
                Text("SERVICE ERROR")
                Button {
                    viewModel.getTrips()
                } label: {
                    Text("Retry")
                }
            }
        }
        .cornerRadius(10)
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
    
    @ViewBuilder var stopInfo: some View {
        if let stopInfo = viewModel.stopInfo, let stop = selectedStop, isShowingStopInfo {
            VStack {
                Text("Stop \(stop.id ?? 0)")
                    .font(.headline)
                HStack {
                    Text("Price: \(String(format: "%.2f", stopInfo.price))€")
                        .font(.subheadline)
                    
                    Text("Stop Time: \(formattedTime(stopInfo.stopTime))")
                        .font(.subheadline)
                }
                Button("Cerrar") {
                    isShowingStopInfo = false
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: isShowingStopInfo)
        }
    }
}

private extension ORMMainView {
    
    var savedFormsCount: Int {
        return viewModel.completedForms.count
    }
    
    func formattedTime(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        } else {
            return date
        }
    }
}

#Preview {
    ORMMainView(viewModel: ORMMainViewModel(ormInteractor: ORMInteractor(networkManager: Network())))
}
