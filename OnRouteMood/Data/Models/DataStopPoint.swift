//
//  ORMStopPoint.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataStopPoint: Decodable, Encodable {
    let id: Int
    let point: DataCoordinate
}
