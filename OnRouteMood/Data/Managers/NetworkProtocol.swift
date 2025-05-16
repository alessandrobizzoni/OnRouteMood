//
//  NetworkProtocol.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation
import Combine

protocol NetworkProtocol {
    
    func getTrips() -> AnyPublisher<[DataTrips], Error>
    
    func getStops() -> AnyPublisher<DataStop, Error>
}
