//
//  ORMTrips.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataTrips: Codable, Identifiable {
    var id = UUID()
    let driverName: String
    let status: String
    let route: String
    let startTime: String
    let origin: DataLocation
    let description: String
    let destination: DataLocation
    let stops: [DataStopPoint?]
    let endTime: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        driverName = try container.decode(String.self, forKey: .driverName)
        status = try container.decode(String.self, forKey: .status)
        route = try container.decode(String.self, forKey: .route)
        startTime = try container.decode(String.self, forKey: .startTime)
        origin = try container.decode(DataLocation.self, forKey: .origin)
        description = try container.decode(String.self, forKey: .description)
        destination = try container.decode(DataLocation.self, forKey: .destination)
        stops = try container.decodeIfPresent([DataStopPoint].self, forKey: .stops) ?? []
        endTime = try container.decode(String.self, forKey: .endTime)
    }
}
