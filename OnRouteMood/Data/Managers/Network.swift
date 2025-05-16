//
//  Network.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation
import Combine

class Network: NetworkProtocol {
    
    static let baseURL = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/"
    
    private let tripsURL = baseURL + "trips.json"
    
    private let stopsURL = baseURL + "stops.json"
    
    func getTrips() -> AnyPublisher<[DataTrips], Error> {
        guard let url = URL(string: tripsURL) else {
            return Fail(error: ORMErrors.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [DataTrips].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getStops() -> AnyPublisher<[DataStop], Error> {
        guard let url = URL(string: tripsURL) else {
            return Fail(error: ORMErrors.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [DataStop].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
