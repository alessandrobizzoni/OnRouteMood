//
//  NetworkTests.swift
//  OnRouteMoodTests
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import XCTest
import Combine
@testable import OnRouteMood

class NetworkTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var network: Network!

    override func setUp() {
        super.setUp()
        network = Network()
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        super.tearDown()
    }

    func testGetTrips() {
        let expectation = XCTestExpectation(description: "Fetch trips")
        
        network.getTrips()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed to fetch trips with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                XCTAssertNotNil(response)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetStops() {
        let expectation = XCTestExpectation(description: "Fetch stops")
        
        network.getStops()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed to fetch stops with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                XCTAssertNotNil(response)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
