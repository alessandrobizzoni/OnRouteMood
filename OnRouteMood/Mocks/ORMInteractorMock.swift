//
//  ORMInteractorMock.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 17/5/25.
//

import Foundation
import Combine

class ORMInteractorMock: ORMInteractorProtocol {
    
    let mockTripsResponse: [DomainTrips] = [
        .init(
            id: UUID(),
            driverName: "Test Name",
            status: .ongoing,
            route: "CODE, Barcelona",
            startTime: "2018-12-18T08:10:00.000Z",
            origin: .init(
                address: "Metropolis:lab, Barcelona",
                point: .init(
                    _latitude: 41.37653,
                    _longitude: 2.17924
                )
            ),
            description: "",
            destination: .init(
                address: "",
                point: .init(
                    _latitude: 42.32,
                    _longitude: 3.3
                )
            ),
            stops: [],
            endTime: "2018-12-18T14:10:00.000Z"
        )
    ]
    
    let mockStopResponse: DomainStop = .init(
        price: 1.5,
        address: "Ramblas, Barcelona",
        tripId: 1,
        paid: true,
        stopTime: "2018-12-18T08:10:00.000Z",
        point: .init(
            _latitude: 41.37653,
            _longitude: 2.17924
        ),
        userName: "Manuel Gomez"
    )
    
    func getTrips() -> AnyPublisher<[DomainTrips], Error> {
        return Just(mockTripsResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
    }
    
    func getStops() -> AnyPublisher<DomainStop, Error> {
        return Just(mockStopResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
