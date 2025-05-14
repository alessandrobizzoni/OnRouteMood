//
//  ORMTrips.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataTrips: Decodable, Identifiable, Encodable {
    var id = UUID()
    let description: String
    let driverName: String
    let route: String
    let status: String
    let origin: DataLocation
    let stops: [DataStopPoint]
    let destination: DataLocation
    let startTime: String
    let endTime: String
}
