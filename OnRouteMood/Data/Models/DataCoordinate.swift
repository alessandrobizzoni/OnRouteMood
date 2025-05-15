//
//  ORMCoordinate.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataCoordinate: Codable {
    let lat: Double?
    let long: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat = "_latitude"
        case long = "_longitude"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        long = try container.decodeIfPresent(Double.self, forKey: .long)
    }
}
