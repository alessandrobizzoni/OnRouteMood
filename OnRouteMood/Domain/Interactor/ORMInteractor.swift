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
            .handleEvents(receiveOutput: { encodedData in
                if let jsonString = String(data: encodedData, encoding: .utf8) {
                    print("[DEBUG JSON ENCODED]: \(jsonString)")
                } else {
                    print("[DEBUG JSON ENCODED]: No se pudo convertir a String")
                }
            })
            .decode(type: [DomainTrips].self, decoder: JSONDecoder())
            .map {
                print("[DEBUG MAP] \($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }
    
}
