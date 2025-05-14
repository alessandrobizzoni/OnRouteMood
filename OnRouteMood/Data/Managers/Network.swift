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
    
    func getTrips() -> AnyPublisher<[DataTrips], Error> {
        let nextUrl: String = tripsURL
        
        guard let url = URL(string: nextUrl) else {
            return Fail(error: ORMErrors.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [DataTrips].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
