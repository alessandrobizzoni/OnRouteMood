//
//  TripStatusTests.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 17/5/25.
//

import XCTest
@testable import OnRouteMood

class TripStatusTests: XCTestCase {

    func testColorForOngoing() {
        let status: TripStatus = .ongoing
        
        let color = status.cardColor
        
        XCTAssertEqual(color, .tripOngoing)
    }
    
    func testColorForScheduled() {
        let status: TripStatus = .scheduled
        
        let color = status.cardColor
        
        XCTAssertEqual(color, .tripScheduled)
    }
    
    func testColorForCancelled() {
        let status: TripStatus = .cancelled
        
        let color = status.cardColor
        
        XCTAssertEqual(color, .tripCancelled)
    }
    
    func testColorForFinalized() {
        let status: TripStatus = .finalized
        
        let color = status.cardColor
        
        XCTAssertEqual(color, .tripFinalized)
    }
}
