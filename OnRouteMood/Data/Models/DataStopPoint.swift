//
//  ORMStopPoint.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataStopPoint: Codable {
    let stopId: Int?
    let stopPoint: DataCoordinate?
    
    enum CodingKeys: String, CodingKey {
        case stopId = "id"
        case stopPoint = "point"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stopId = try container.decodeIfPresent(Int.self, forKey: .stopId)
        stopPoint = try container.decodeIfPresent(DataCoordinate.self, forKey: .stopPoint)
    }
}
