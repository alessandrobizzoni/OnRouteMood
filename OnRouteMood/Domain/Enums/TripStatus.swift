//
//  TripStatus.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 15/5/25.
//

enum TripStatus: String, Decodable, Encodable {
    case ongoing
    case scheduled
    case finalized
    case cancelled
}
