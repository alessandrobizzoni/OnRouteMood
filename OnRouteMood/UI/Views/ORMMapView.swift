//
//  ORMMapView.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import SwiftUI
import Polyline
import MapKit

struct ORMMapView: View {
    
    @Binding var selectedBus: DomainTrips?
    
    @Binding var selectedStop: DomainStopPoint?
    
    @Binding var isShowingStopInfo: Bool
    
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.38, longitude: 2.18),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            if let origin = selectedBus?.origin.point,
               let destination = selectedBus?.destination.point,
               let lat1 = origin._latitude, let lon1 = origin._longitude,
               let lat2 = destination._latitude, let lon2 = destination._longitude {
                Annotation("Origin", coordinate: CLLocationCoordinate2D(latitude: lat1, longitude: lon1)) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.yellow.opacity(0.5))
                            .frame(width: 20, height: 20)
                        
                        Image(systemName: "bus.fill")
                            .symbolEffect(.variableColor)
                            .padding(8)
                            .foregroundStyle(.black)
                            .background(Color.yellow)
                            .clipShape(Circle())
                    }
                }

                Marker("To", systemImage: "flag.fill", coordinate: CLLocationCoordinate2D(latitude: lat2, longitude: lon2))
            }
            
            if let stops = selectedBus?.stops {
                ForEach(Array(stops.enumerated()), id: \.offset) { index, stop in
                    if let lat = stop?.point?._latitude, let lon = stop?.point?._longitude {
                        Annotation(
                            "Stop \(index + 1)",
                            coordinate: CLLocationCoordinate2D(
                                latitude: lat,
                                longitude: lon
                            )
                        ) {
                            Label("", systemImage: "mappin.circle.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .blue)
                                .onTapGesture {
                                    selectedStop = stop
                                    isShowingStopInfo = true
                                }
                        }
                    }
                }
            }
            
            if !routeCoordinates.isEmpty {
                MapPolyline(coordinates: routeCoordinates)
                    .stroke(Color.yellow, lineWidth: 4)
            }
            
        }
        .cornerRadius(20)
        .frame(height: 425)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
        .shadow(radius: 5)
        .onChange(of: selectedBus) { oldValue, newValue in
            if let selectedBus = newValue {
                if let coords = decodePolyline(selectedBus.route) {
                    routeCoordinates = coords
                    centerMapToFitRoute(coords)
                }
            }
        }
    }
}

private extension ORMMapView {
    
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
