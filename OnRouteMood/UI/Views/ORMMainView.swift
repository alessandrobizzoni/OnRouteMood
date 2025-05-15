//
//  ORMMainView.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import SwiftUI
import Polyline

struct ORMMainView: View {
    
    @StateObject var viewModel: ORMMainViewModel
    
    @State var selectedBus: DomainTrips? = nil
    
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.38, longitude: 2.18),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        VStack {
            Text("OnRouteMood")
                .font(.title2)
                .fontWeight(.bold)
            
            if let bus = selectedBus {
                VStack {
                    Text("Selected Bus:")
                    Text("\(bus.origin.address) to \(bus.destination.address)")
                }
            }
            
            mapView
                .padding()
            
            listTripView
        }
        .padding()
        .background(Color.primaryORM)
        .navigationTitle("OnRouteMood")
        .onAppear {
            viewModel.getTrips()
        }
    }
}

import MapKit

private extension ORMMainView {
    
    var listTripView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(viewModel.allTrips, id: \.id) { trip in
                Button {
                    selectedBus = trip
                    
                    if let coords = decodePolyline(trip.route) {
                        routeCoordinates = coords
                        centerMapToFitRoute(coords)
                    }
                } label: {
                    ORMTripCard(trip: trip)
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
    
    var mapView: some View {
        Map(position: $cameraPosition) {
            
            if let origin = selectedBus?.origin.point,
               let destination = selectedBus?.destination.point,
               let lat1 = origin.lat, let lon1 = origin.long,
               let lat2 = destination.lat, let lon2 = destination.long {
                
                Marker("Origen", coordinate: CLLocationCoordinate2D(latitude: lat1, longitude: lon1))
                Marker("Destino", coordinate: CLLocationCoordinate2D(latitude: lat2, longitude: lon2))
            }
            
            // Añadir la polilínea si hay coordenadas
            if !routeCoordinates.isEmpty {
                MapPolyline(coordinates: routeCoordinates)
                    .stroke(Color.blue, lineWidth: 4)
            }
            
        }
        .cornerRadius(20)
        .frame(height: 425)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
        .shadow(radius: 5)
    }
}

private extension ORMMainView {
    
    func centerMapToFitRoute(_ coordinates: [CLLocationCoordinate2D]) {
        guard !coordinates.isEmpty else { return }
        
        let lats = coordinates.map { $0.latitude }
        let longs = coordinates.map { $0.longitude }
        
        let minLat = lats.min() ?? 0
        let maxLat = lats.max() ?? 0
        let minLong = longs.min() ?? 0
        let maxLong = longs.max() ?? 0
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLong + maxLong) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLong - minLong) * 1.5
        )
        
        withAnimation {
            cameraPosition = .region(
                MKCoordinateRegion(center: center, span: span)
            )
        }
    }
    
    func decodePolyline(_ encodedPolyline: String) -> [CLLocationCoordinate2D]? {
        let polyline = Polyline(encodedPolyline: encodedPolyline)
            return polyline.coordinates
    }
}

#Preview {
    ORMMainView(viewModel: ORMMainViewModel(ormInteractor: .init(networkManager: Network())))
}
