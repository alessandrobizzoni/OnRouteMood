//
//  NetworkMock.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import Foundation
import Combine

class NetworkMock: NetworkProtocol {
    
    let mockTripsResponse = """
    [
        {
            "driverName": "Alberto Morales",
            "status": "ongoing",
            "route": "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
            "startTime": "2018-12-18T08:00:00.000Z",
            "origin": {
                "address": "Metropolis:lab, Barcelona",
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                }
            },
            "description": "Barcelona a Martorell",
            "destination": {
                "point": {
                    "_latitude": 41.49958,
                    "_longitude": 1.90307
                },
                "address": "Seat HQ, Martorell"
            },
            "stops": [
                {
                    "point": {
                        "_latitude": 41.37653,
                        "_longitude": 2.17924
                    },
                    "id": 1
                },
                {
                    "point": {
                        "_latitude": 41.35179,
                        "_longitude": 2.15494
                    },
                    "id": 2
                },
                {
                    "point": {
                        "_latitude": 41.43853,
                        "_longitude": 2.00094
                    },
                    "id": 3
                },
                {
                    "point": {
                        "_latitude": 41.47711,
                        "_longitude": 1.91843
                    },
                    "id": 4
                }
            ],
            "endTime": "2018-12-18T09:00:00.000Z"
        },
        {
            "driverName": "Joaquin Sabina",
            "destination": {
                "point": {
                    "_latitude": 41.46693,
                    "_longitude": 2.08006
                },
                "address": "Sant Cugat Centre, El Valles"
            },
            "endTime": "2018-12-18T08:45:00.000Z",
            "description": "Barcelona a Sant cugat",
            "status": "ongoing",
            "stops": [
                {
                    "point": {
                        "_latitude": 41.39869,
                        "_longitude": 2.1692
                    },
                    "id": 5
                },
                {
                    "point": {
                        "_latitude": 41.42522,
                        "_longitude": 2.09084
                    },
                    "id": 6
                }
            ],
            "origin": {
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                },
                "address": "Metropolis:lab, Barcelona"
            },
            "route": "sdq{Fc}iLeoBrgBs@xsGecD|sEswEv|Cek@cyA",
            "startTime": "2018-12-18T08:00:00.000Z"
        },
        {
            "endTime": "2018-12-18T07:50:00.000Z",
            "route": "sdq{Fc}iLurAy{AyiEabDgfDhqEgyB|gA{x@xv@{x@rsF",
            "stops": [
                {
                    "id": 7,
                    "point": {
                        "_latitude": 41.42658,
                        "_longitude": 2.22688
                    }
                },
                {
                    "id": 8,
                    "point": {
                        "_latitude": 41.48216,
                        "_longitude": 2.17263
                    }
                }
            ],
            "status": "ongoing",
            "origin": {
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                },
                "address": "Metropolis:lab, Barcelona"
            },
            "description": "Barcelona a Cerdanyola",
            "destination": {
                "address": "Cerdanyola Centre, El Valles",
                "point": {
                    "_latitude": 41.4914,
                    "_longitude": 2.13349
                }
            },
            "startTime": "2018-12-18T07:00:00.000Z",
            "driverName": "Rosalia"
        },
        {
            "description": "Girona  a Banyoles",
            "driverName": "Fernando Castaño",
            "destination": {
                "point": {
                    "_latitude": 42.12741,
                    "_longitude": 2.76088
                },
                "address": "Banyoles, Pla de l' estany"
            },
            "endTime": "2018-12-24T16:30:00.000Z",
            "route": "mif_GoifP}`F?auAst@qdCxmA}lD|GikF`aEfUl}AisAj_A",
            "stops": [
                {
                    "point": {
                        "_latitude": 42.07967,
                        "_longitude": 2.81734
                    },
                    "id": 9
                },
                {
                    "id": 10,
                    "point": {
                        "_latitude": 42.10362,
                        "_longitude": 2.80567
                    }
                }
            ],
            "status": "scheduled",
            "startTime": "2018-12-24T16:00:00.000Z",
            "origin": {
                "address": "Girona centre, Girona",
                "point": {
                    "_latitude": 41.98055,
                    "_longitude": 2.8228
                }
            }
        },
        {
            "route": "sdq{Fc}iLqsCcsByoCgjBelAmT",
            "endTime": "2018-12-19T09:00:00.000Z",
            "driverName": "Luciano fernando de la caslada y Maria",
            "startTime": "2018-12-19T08:00:00.000Z",
            "description": "Barcelona a Badalona",
            "stops": [
                {}
            ],
            "status": "cancelled",
            "origin": {
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                },
                "address": "Metropolis:lab, Barcelona"
            },
            "destination": {
                "point": {
                    "_latitude": 41.44003,
                    "_longitude": 2.22511
                },
                "address": "Badalona centre, Barcelona"
            }
        },
        {
            "origin": {
                "address": "SEAT HQ, Martorell",
                "point": {
                    "_latitude": 41.49958,
                    "_longitude": 1.90307
                }
            },
            "status": "scheduled",
            "description": "Martorell a Barcelona",
            "driverName": "Concha Piquer",
            "startTime": "2018-12-18T15:00:00.000Z",
            "stops": [
                {}
            ],
            "endTime": "2018-12-18T16:00:00.000Z",
            "destination": {
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                },
                "address": "Metropolis:lab, Barcelona"
            },
            "route": "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@"
        },
        {
            "driverName": "John Smith",
            "description": "Sant Cugat a Barcelona",
            "status": "finalized",
            "startTime": "2018-12-16T09:00:00.000Z",
            "route": "sdq{Fc}iLeoBrgBs@xsGecD|sEswEv|Cek@cyA",
            "endTime": "2018-12-16T10:00:00.000Z",
            "destination": {
                "point": {
                    "_latitude": 41.38074,
                    "_longitude": 2.18594
                },
                "address": "Metropolis:lab, Barcelona"
            },
            "origin": {
                "point": {
                    "_latitude": 41.46693,
                    "_longitude": 2.08006
                },
                "address": "Sant Cugat Centre, El Valles"
            },
            "stops": [
                {}
            ]
        }
    ]
    
    """
    let mock: DataStop = .init(
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
    
    func getTrips() -> AnyPublisher<[DataTrips], Error> {
        guard let jsonData = mockTripsResponse.data(using: .utf8) else {
            return Fail(error: NSError(domain: "TestErrorDomain", code: 100, userInfo: [NSLocalizedDescriptionKey: "No se pudo convertir el JSON a Data"]))
                .eraseToAnyPublisher()
        }
        
        do {
            let trips = try JSONDecoder().decode([DataTrips].self, from: jsonData)
            
            return Just(trips)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func getStops() -> AnyPublisher<DataStop, Error> {
        return Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
