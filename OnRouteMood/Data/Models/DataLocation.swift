//
//  ORMLocation.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DataLocation: Decodable, Equatable, Encodable {
    let address: String?
    let point: DataCoordinate?
}
