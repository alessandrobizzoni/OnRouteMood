//
//  ORMStopPoint.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation

struct DomainStopPoint: Decodable, Equatable {
    let id: Int?
    let point: DomainCoordinate?
}
