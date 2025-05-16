//
//  ORMStopPoint.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataStopPoint: Decodable, Equatable, Encodable {
    let id: Int?
    let point: DataCoordinate?
    
    enum CodingKeys: String, CodingKey {
        case id
        case point
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        point = try container.decodeIfPresent(DataCoordinate.self, forKey: .point)
    }
}
