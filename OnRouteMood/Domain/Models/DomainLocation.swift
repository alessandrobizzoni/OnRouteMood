//
//  ORMLocation.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainLocation: Decodable {
    let address: String
    let point: DomainCoordinate
}
