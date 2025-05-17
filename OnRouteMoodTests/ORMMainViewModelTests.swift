//
//  ORMMainViewModelTests.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 17/5/25.
//

import XCTest
import Combine
@testable import OnRouteMood

class ORMMainViewModelTests: XCTestCase {
    
    var viewModel: ORMMainViewModel!
    var ormInteractor: ORMInteractorProtocol!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        ormInteractor = ORMInteractorMock()
        viewModel = ORMMainViewModel(ormInteractor: ormInteractor)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        ormInteractor = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetTrips() {
        let expectation = expectation(description: "Trips received")
        
        viewModel.getTrips()
        
        ormInteractor.getTrips()
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
    
    func testGetStop() {
        let expectation = expectation(description: "Trips received")
        
        viewModel.getStop()
        
        ormInteractor.getStops()
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
