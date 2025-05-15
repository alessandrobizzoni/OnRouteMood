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
        guard let url = URL(string: tripsURL) else {
            return Fail(error: ORMErrors.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                // Debug: mostrar el JSON como String para ver qué llega
                if let jsonString = String(data: output.data, encoding: .utf8) {
                    print("[DEBUG JSON]: \(jsonString)")
                }
                return output.data
            }
            .decode(type: [DataTrips].self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { trips in
                print("[DEBUG DECODED]: \(trips)")
            })
            .mapError { error in
                        // Captura y muestra el error de decodificación si hay
                        print("[DEBUG DECODE ERROR]: \(error)")
                        return error
                    }
            .eraseToAnyPublisher()
    }

}
