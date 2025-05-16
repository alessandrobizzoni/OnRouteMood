//
//  ORMTrips.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainTrips: Identifiable, Codable, Equatable {
    let id: UUID
    let driverName: String
    let status: TripStatus
    let route: String
    let startTime: String
    let origin: DomainLocation
    let description: String
    let destination: DomainLocation
    let stops: [DomainStopPoint?]
    let endTime: String
}
