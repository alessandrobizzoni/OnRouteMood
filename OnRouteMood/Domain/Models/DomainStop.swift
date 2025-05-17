//
//  ORMStop.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainStop: Codable, Equatable {
    let price: Double
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: String
    let point: DomainCoordinate
    let userName: String
}
