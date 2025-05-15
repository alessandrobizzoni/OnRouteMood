//
//  ORMTripCard.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 15/5/25.
//

import SwiftUI

struct ORMTripCard: View {
    
    let trip: DomainTrips
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Text("\(trip.origin.address)")
                Spacer()
                Image(systemName: "arrow.right")
                Spacer()
                Text("\(trip.destination.address)")
            }
            Text("Salida: ")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}
