//
//  ORMStop.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainStop {
    var id = UUID()
    let stopTime: String
    let paid: Bool
    let address: String
    let tripId: Int
    let userName: String
    let point: DomainCoordinate
    let price: Double
}
