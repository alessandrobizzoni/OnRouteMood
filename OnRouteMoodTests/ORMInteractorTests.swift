//
//  OnRouteMoodTests.swift
//  OnRouteMoodTests
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import XCTest
import Combine
@testable import OnRouteMood

class ORMInteractorTests: XCTestCase {
    
    var interactor: ORMInteractor!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        interactor = ORMInteractor(networkManager: NetworkMock())
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        interactor = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetTrips() {
        let expectation = expectation(description: "Trips received")
        
        interactor.getTrips()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error occurred: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                XCTAssertNotNil(response)
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
