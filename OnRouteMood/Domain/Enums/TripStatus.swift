//
//  TripStatus.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 15/5/25.
//

import SwiftUI

enum TripStatus: String, Decodable, Encodable, Equatable {
    case ongoing
    case scheduled
    case finalized
    case cancelled
    
    var cardColor: Color {
        switch self {
        case .ongoing:
            return .tripOngoing
        case .scheduled:
            return .tripScheduled
        case .finalized:
            return .tripFinalized
        case .cancelled:
            return .tripCancelled
        }
    }
}
