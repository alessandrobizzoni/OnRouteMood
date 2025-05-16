//
//  ORMInteractor.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation
import Combine

struct ORMInteractor: ORMInteractorProtocol {
    
    let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func getTrips() -> AnyPublisher<[DomainTrips], Error> {
        return networkManager.getTrips()
            .encode(encoder: JSONEncoder())
            .decode(type: [DomainTrips].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
