//
//  ORMInteractorProtocol.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Combine

protocol ORMInteractorProtocol {
    
    func getTrips() -> AnyPublisher<[DomainTrips], Error>
    
    func getStops() -> AnyPublisher<DomainStop, Error>
}
