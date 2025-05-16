//
//  ORMTripCard.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 15/5/25.
//

import SwiftUI

struct ORMTripCard: View {
    
    let trip: DomainTrips
    
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text("From:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(trip.origin.address ?? "")
                        .font(.subheadline)
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.blue)
                Spacer()
                VStack(alignment: .leading) {
                    Text("To:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(trip.destination.address ?? "")
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            
            Text("Start at: \(formattedTime(trip.startTime))")
                .font(.footnote)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Driver: \(trip.driverName)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Status: \(trip.status.rawValue.uppercased())")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(tripsStatusColor)
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
                .fill(Color(trip.status.cardColor))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

private extension ORMTripCard {
    var tripsStatusColor: Color {
        switch trip.status {
        case .ongoing:
            return .black
        case .scheduled:
            return .orange
        case .cancelled, .finalized:
            return .red
        }
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
