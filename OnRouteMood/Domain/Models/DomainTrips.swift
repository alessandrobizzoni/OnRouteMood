//
//  ORMTrips.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainTrips: Identifiable, Decodable {
    var id: UUID { UUID() }
    let description: String
    let driverName: String
    let route: String
    let status: String
    let origin: DomainLocation
    let stops: [DomainStopPoint]
    let destination: DomainLocation
    let startTime: String
    let endTime: String
}
